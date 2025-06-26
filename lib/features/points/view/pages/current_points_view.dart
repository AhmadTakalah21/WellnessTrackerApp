import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wellnesstrackerapp/features/points/view/points_view.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class CurrentPointsView extends StatelessWidget {
  const CurrentPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepCounter(context),
          const SizedBox(height: 32),
          _buildChart(context),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final List<ChartModel> data = [
      ChartModel(xAxisProperty: "Jan", yAxisProperty: [100]),
      ChartModel(xAxisProperty: "Feb", yAxisProperty: [300]),
      ChartModel(xAxisProperty: "Mar", yAxisProperty: [350]),
      ChartModel(xAxisProperty: "May", yAxisProperty: [500]),
      ChartModel(xAxisProperty: "Jun", yAxisProperty: [700]),
      ChartModel(xAxisProperty: "Jul", yAxisProperty: [700]),
      ChartModel(xAxisProperty: "Aug", yAxisProperty: [1000]),
    ];
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
            maximum: 1200,
            interval: 200,
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
              dataSource: data,
              color: context.cs.primary,
              width: 3,
              animationDuration: 1000,
              xValueMapper: (point, _) => point.xAxisProperty,
              yValueMapper: (point, _) => point.yAxisProperty[0],
              markerSettings: const MarkerSettings(isVisible: true),
              name: 'النقاط',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepCounter(BuildContext context) {
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
                    "1000",
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
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey.shade200,
                    color: context.cs.primary,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "أنت في منتصف الطريق نحو هدفك 💪",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: context.cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
