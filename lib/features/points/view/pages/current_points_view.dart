import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart';
import 'package:wellnesstrackerapp/features/points/model/points_chart_model/points_chart_model.dart';
import 'package:wellnesstrackerapp/features/points/view/points_view.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class CurrentPointsViewCallBacks {
  Future<void> onRefresh();
  void onTryAgainTap();
}

@RoutePage()
class CurrentPointsView extends StatelessWidget {
  const CurrentPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CurrentPointsPage();
  }
}

class CurrentPointsPage extends StatefulWidget {
  const CurrentPointsPage({super.key});

  @override
  State<CurrentPointsPage> createState() => _CurrentPointsPageState();
}

class _CurrentPointsPageState extends State<CurrentPointsPage>
    implements CurrentPointsViewCallBacks {
  late final PointsCubit pointsCubit = context.read();

  @override
  void initState() {
    super.initState();
    pointsCubit.getPoints();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => pointsCubit.getPoints();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PointsCubit, GeneralPointsState>(
        buildWhen: (previous, current) => current is PointsState,
        builder: (context, state) {
          if (state is PointsLoading) {
            return LoadingIndicator();
          } else if (state is PointsSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStepCounter(context, state.points.totalPoints),
                    const SizedBox(height: 32),
                    _buildChart(context, state.points.chartData),
                    SizedBox(height: 110),
                  ],
                ),
              ),
            );
          } else if (state is PointsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<PointsChartModel> data) {
    final List<ChartModel> chartData = data
        .map((e) => ChartModel(
              xAxisProperty: e.month,
              yAxisProperty: [e.points.toDouble()],
              color: Colors.black
            ))
        .toList();
    final points = data.map((e) => e.points).toList();
    int? maxNumber;
    if (points.isNotEmpty) {
      maxNumber = points.reduce((a, b) => a > b ? a : b) * 2;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SfCartesianChart(
          title: ChartTitle(
            text: "الرسم البياني لتقدم النقاط",
            textStyle: context.tt.titleLarge,
          ),
          borderWidth: 0,
          plotAreaBorderWidth: 0,
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: maxNumber == null || maxNumber == 0
                ? 1200
                : maxNumber.toDouble(),
            interval: maxNumber == null || maxNumber == 0
                ? 200
                : (maxNumber.toDouble() / 6).ceilToDouble(),
            majorGridLines: const MajorGridLines(width: 0.5),
            labelStyle: context.tt.bodyMedium,
          ),
          primaryXAxis: CategoryAxis(
            labelStyle: context.tt.bodyMedium,
            majorGridLines: const MajorGridLines(width: 0),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: [
            LineSeries<ChartModel, String>(
              dataSource: chartData,
              color: context.cs.primary,
              width: 3,
              animationDuration: 1000,
              xValueMapper: (point, _) => point.xAxisProperty,
              yValueMapper: (point, _) => point.yAxisProperty[0],
              markerSettings: const MarkerSettings(isVisible: true),
              name: 'points'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepCounter(BuildContext context, int totalPoints) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.8, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.borderRadius20,
            ),
            elevation: 10,
            shadowColor: context.cs.primary.withOpacity(0.2),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.cs.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events_rounded,
                      color: context.cs.primary,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    totalPoints.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: context.cs.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "نقطة",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // LinearProgressIndicator(
                  //   value: 0.5,
                  //   backgroundColor: Colors.grey.shade200,
                  //   color: context.cs.primary,
                  //   minHeight: 8,
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   "أنت في منتصف الطريق نحو هدفك 💪",
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 14,
                  //     color: context.cs.primary,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
