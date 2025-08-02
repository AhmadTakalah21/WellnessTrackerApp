import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';

@immutable
class PlanDayItemToShowModel {
  const PlanDayItemToShowModel({
    required this.day,
    this.meals = const [],
  });

  final DayEnum day;
  final List<MealModel> meals;

  PlanDayItemToShowModel copyWith({
    DayEnum? Function()? day,
    List<MealModel>? meals,
  }) {
    return PlanDayItemToShowModel(
      day: this.day,
      meals: meals ?? this.meals,
    );
  }
}
