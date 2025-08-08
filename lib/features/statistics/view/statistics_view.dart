import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellnesstrackerapp/features/points/view/points_view.dart';
import 'package:wellnesstrackerapp/features/statistics/cubit/statistics_cubit.dart';
import 'package:wellnesstrackerapp/features/statistics/model/stats_model/stats_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class StatisticsViewCallBacks {
  Future<void> onRefresh();
  void onTryAgainTap();
}

@RoutePage()
class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<StatisticsCubit>(),
      child: const StatisticsPage(),
    );
  }
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    implements StatisticsViewCallBacks {
  late final StatisticsCubit statisticsCubit = context.read();

  @override
  void initState() {
    super.initState();
    statisticsCubit.getStats();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => statisticsCubit.getStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("statistics".tr())),
      body: BlocBuilder<StatisticsCubit, GeneralStatisticsState>(
        buildWhen: (previous, current) => current is StatisticsState,
        builder: (context, state) {
          if (state is StatisticsLoading) {
            return LoadingIndicator();
          } else if (state is StatisticsSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    _buildChart(context, state.statistics),
                    SizedBox(height: 110),
                  ],
                ),
              ),
            );
          } else if (state is StatisticsFail) {
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

  Widget _buildChart(BuildContext context, StatsModel stats) {
    final List<ChartModel> chartData = [
      ChartModel(
        xAxisProperty: "active_users".tr(),
        yAxisProperty: [stats.activeUsers.toDouble()],
      ),
      ChartModel(
        xAxisProperty: "diet_users".tr(),
        yAxisProperty: [stats.dietitianUsers.toDouble()],
      ),
      ChartModel(
        xAxisProperty: "exercise_users".tr(),
        yAxisProperty: [stats.exerciseUsers.toDouble()],
      ),
      ChartModel(
        xAxisProperty: "male_users".tr(),
        yAxisProperty: [stats.maleUsers.toDouble()],
      ),
      ChartModel(
        xAxisProperty: "female_users".tr(),
        yAxisProperty: [stats.femaleUsers.toDouble()],
      ),
      ChartModel(
        xAxisProperty: "avg_ages".tr(),
        yAxisProperty: [stats.avgAgesUsers],
      ),
      ChartModel(
        xAxisProperty: "avg_weights".tr(),
        yAxisProperty: [stats.avgWeightsUsers],
      ),
      ChartModel(
        xAxisProperty: "avg_lenghts".tr(),
        yAxisProperty: [stats.avgLengthsUsers],
      ),
    ];

    final List<Color> columnColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];

    final points = chartData.map((e) => e.yAxisProperty[0].toInt()).toList();
    int? maxNumber;
    if (points.isNotEmpty) {
      maxNumber = points.reduce((a, b) => a > b ? a : b) * 2;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SfCartesianChart(
              title: ChartTitle(
                text: "statistics".tr(),
                textStyle: context.tt.titleLarge,
              ),
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryYAxis: NumericAxis(
                // minimum: 0,
                // maximum: 1200,
                // interval: 200,
                maximum: maxNumber?.toDouble() ?? 1200,
                interval: maxNumber == null
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
              series: List<CartesianSeries<ChartModel, String>>.generate(
                chartData[0].yAxisProperty.length,
                (index) => ColumnSeries<ChartModel, String>(
                  width: 0.3,
                  dataSource: chartData,
                  animationDuration: 1000,
                  xValueMapper: (ChartModel xAxis, ind) =>
                      "$ind",
                  yValueMapper: (ChartModel yAxis, ind) =>
                      yAxis.yAxisProperty[index],
                  pointColorMapper: (_, index) =>
                      columnColors[index % columnColors.length],
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  name: "stats".tr(),
                ),
              ),
            ),
            SizedBox(height: 100),
            Wrap(
              spacing: 12,
              runSpacing: 20,
              children: List.generate(chartData.length, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: columnColors[index % columnColors.length],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      chartData[index].xAxisProperty,
                      style: context.tt.bodyMedium,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
