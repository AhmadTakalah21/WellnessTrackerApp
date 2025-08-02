import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';

@immutable
class ExercisePlanDayItemToShowModel {
  const ExercisePlanDayItemToShowModel({
    required this.day,
    this.exercises = const [],
  });

  final DayEnum day;
  final List<ExerciseModel> exercises;

  ExercisePlanDayItemToShowModel copyWith({
    DayEnum? Function()? day,
    List<ExerciseModel>? exercises,
  }) {
    return ExercisePlanDayItemToShowModel(
      day: this.day,
      exercises: exercises ?? this.exercises,
    );
  }
}
