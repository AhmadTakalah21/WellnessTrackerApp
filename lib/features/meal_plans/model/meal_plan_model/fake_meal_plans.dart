import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/fake_meta.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

final fakeMealPlans = PaginatedModel<MealPlanModel>(
  data: [
    MealPlanModel(
      id: 1,
      name: "keto",
      dietitianId: 1,
      planDays: List.generate(
        7,
        (dayIndex) => PlanDayModel(
          id: dayIndex + 1,
          day: DayEnum.values[dayIndex],
          meals: List.generate(
            3,
            (mealIndex) => MealModel(
              id: mealIndex + 1,
              dietitianId: 1,
              link: "https://www.google.com",
              type: MealTypeEnum.values[mealIndex],
              description: "description for how to make the meal",
              name: "Meal ${mealIndex + 1}",
              ingredients: List.generate(
                2,
                (index) {
                  return IngredientWithQuantityModel(
                    id: index + 1,
                    quantity: 2,
                    ingredient: IngredientModel(
                      id: index + 1,
                      name: "ingredient ${index + 1}",
                      unit: IngredientUnitEnum.values[index],
                      calories: '10',
                      carbs: "10",
                      proteins: "10",
                      dietitianId: 1,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    )
  ],
  meta: fakeMeta,
);
