import 'package:wellnesstrackerapp/features/customers/model/customer_model/fake_customer.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_model/exercise_plan_day_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_description_model/exercise_description_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/fake_meta.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

final fakeExercisePlans = PaginatedModel<ExercisePlanModel>(
  data: List.generate(3, (index) {
    return ExercisePlanModel(
      id: index + 1,
      name: "Exercise ${index + 1}",
      coachId: 1,
      planDays: List.generate(
        7,
        (dayIndex) => ExercisePlanDayModel(
          id: dayIndex + 1,
          day: DayEnum.values[dayIndex],
          exercises: List.generate(
            3,
            (exerciseIndex) => ExerciseModel(
              id: exerciseIndex + 1,
              coach: fakeCustomer,
              link: "https://www.google.com",
              name: "Exercise ${exerciseIndex + 1}",
              description: ExerciseDescriptionModel(
                rounds: 3,
                explain: "Description for how to do the exercise",
                repeats: List.generate(3, (index) => 10 + (index * 2)),
              ),
              createdAt: DateTime.now().formatYYYYMMDD,
            ),
          ),
        ),
      ),
    );
  }),
  meta: fakeMeta,
);
