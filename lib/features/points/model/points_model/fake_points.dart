import 'package:wellnesstrackerapp/features/points/model/points_chart_model/points_chart_model.dart';
import 'package:wellnesstrackerapp/features/points/model/points_model/points_model.dart';

final fakePoints = PointsModel(
  totalPoints: 1000,
  chartData: List.generate(
    8,
    (index) => PointsChartModel(
      month: "month ${index + 1}",
      points: (index + 1) * 150,
    ),
  ),
);
