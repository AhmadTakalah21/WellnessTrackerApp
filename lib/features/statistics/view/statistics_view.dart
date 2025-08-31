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
    final active = stats.activeUsers.toDouble();
    final dietitian = stats.dietitianUsers.toDouble();
    final exercise = stats.exerciseUsers.toDouble();
    final male = stats.maleUsers.toDouble();
    final female = stats.femaleUsers.toDouble();
    final List<ChartModel> chartData = [
      ChartModel(
        xAxisProperty: "avg_ages".tr(),
        yAxisProperty: [stats.avgAgesUsers],
        color: Colors.teal,
      ),
      ChartModel(
        xAxisProperty: "avg_weights".tr(),
        yAxisProperty: [stats.avgWeightsUsers],
        color: Colors.brown,
      ),
      ChartModel(
        xAxisProperty: "avg_lenghts".tr(),
        yAxisProperty: [stats.avgLengthsUsers],
        color: Colors.indigo,
      ),
      ChartModel(
        xAxisProperty: "active_users".tr(),
        yAxisProperty: [active],
        color: Colors.blue,
      ),
      ChartModel(
        xAxisProperty: "diet_users".tr(),
        yAxisProperty: [(100 * dietitian) / active, dietitian],
        isInChart: false,
        color: Colors.green,
        icon: Icons.restaurant_menu_rounded,
      ),
      ChartModel(
        xAxisProperty: "exercise_users".tr(),
        yAxisProperty: [(100 * exercise) / active, exercise],
        isInChart: false,
        color: Colors.orange,
        icon: Icons.fitness_center_rounded,
      ),
      ChartModel(
        xAxisProperty: "male_users".tr(),
        yAxisProperty: [(100 * male) / active, male],
        isInChart: false,
        color: Colors.purple,
        icon: Icons.male,
      ),
      ChartModel(
        xAxisProperty: "female_users".tr(),
        yAxisProperty: [(100 * female) / active, female],
        isInChart: false,
        color: Colors.red,
        icon: Icons.female,
      ),
      ChartModel(
        xAxisProperty: "most_used_code".tr(),
        yAxisProperty: [stats.mostCodeUsed.total.toDouble()],
        isInChart: false,
        color: Colors.cyan,
        icon: Icons.qr_code,
      ),
    ];

    final dataSource = chartData.where((data) => data.isInChart).toList();

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
            Padding(
              padding: AppConstants.paddingH4,
              child: SfCartesianChart(
                title: ChartTitle(
                  text: "statistics".tr(),
                  textStyle: context.tt.titleLarge,
                ),
                borderWidth: 0,
                plotAreaBorderWidth: 0,
                primaryYAxis: NumericAxis(
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
                    width: 0.5,
                    dataSource: dataSource,
                    borderRadius: AppConstants.borderRadiusT5,
                    animationDuration: 1000,
                    xValueMapper: (ChartModel xAxis, ind) => " " * ind,
                    yValueMapper: (ChartModel yAxis, ind) =>
                        yAxis.yAxisProperty[index],
                    pointColorMapper: (_, index) => dataSource[index].color,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    name: "stats".tr(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 20,
              children: List.generate(chartData.length, (index) {
                final item = chartData[index];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.isInChart)
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    if (item.icon != null)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: item.color.withAlpha((0.2 * 255).toInt()),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(item.icon, color: item.color),
                        ),
                      ),
                    const SizedBox(width: 6),
                    Text(item.xAxisProperty, style: context.tt.bodyMedium),
                    if (!item.isInChart) ...[
                      const SizedBox(width: 6),
                      if(item.icon == Icons.qr_code)
                      Text(
                        "${stats.mostCodeUsed.code}: (${item.yAxisProperty[0].toStringAsFixed(0)})",
                        style: context.tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if(item.icon != Icons.qr_code)
                      Text(
                        "${item.yAxisProperty[1].toStringAsFixed(0)}  (${item.yAxisProperty[0].toStringAsFixed(0)} %)",
                        style: context.tt.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
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
