import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class MealsViewCallbacks {}

@RoutePage()
class MealsView extends StatelessWidget {
  const MealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MealsPage();
  }
}

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> implements MealsViewCallbacks {
  @override
  Widget build(BuildContext context) {
    final meals = [
      MealModel(
        id: 1,
        dietitianId: 1,
        link: "https://www.google.com",
        type: MealTypeEnum.breakfast,
        name: "الوجبة الأولى - الفطور",
        ingredients: [
          IngredientWithQuantityModel(
            id: 1,
            ingredientId: 1,
            quantity: 2,
            ingredient: IngredientModel(
              id: 1,
              dietitianId: 2,
              unit: IngredientUnitEnum.gram,
              name: 'حليب',
              calories: "120",
              proteins: "8g",
              carbs: "12g",
            ),
          ),
          IngredientWithQuantityModel(
            id: 2,
            ingredientId: 2,
            quantity: 3,
            ingredient: IngredientModel(
              id: 2,
              dietitianId: 2,
              unit: IngredientUnitEnum.gram,
              name: 'بيض',
              calories: "140",
              proteins: "12g",
              carbs: "1g",
            ),
          )
        ],
        description:
            "اولا نقوم بفقس البيض في وعاء , ثم نضع القليل من الملح ونخلطهم خلطا جيدا  , ثم نضع المقلاة على النار ونضع عليها زيت الزيتون وننتظر حوالي دقيقتان, ثم نقوم بسكب البيض على المقلاة ونقوم بتحركهم قليلا وثانيا نضع الحليب على النار حتى يسخن و ممكن اضافة القليل من السكر ",
      ),
      MealModel(
          id: 2,
          dietitianId: 2,
          link: "https://www.google.com",
          type: MealTypeEnum.lunch,
          name: "الوجبة الثانية - الغداء",
          ingredients: [
            IngredientWithQuantityModel(
              id: 1,
              ingredientId: 1,
              quantity: 2,
              ingredient: IngredientModel(
                id: 1,
                dietitianId: 1,
                unit: IngredientUnitEnum.gram,
                name: 'دجاج',
                calories: "200",
                proteins: "30g",
                carbs: "0g",
              ),
            ),
            IngredientWithQuantityModel(
              id: 2,
              ingredientId: 2,
              quantity: 2,
              ingredient: IngredientModel(
                id: 2,
                dietitianId: 2,
                name: 'رز',
                unit: IngredientUnitEnum.gram,
                calories: "180",
                proteins: "4g",
                carbs: "40g",
              ),
            )
          ],
          description:
              "اولا نقوم بفقس البيض في وعاء , ثم نضع القليل من الملح ونخلطهم خلطا جيدا  , ثم نضع المقلاة على النار ونضع عليها زيت الزيتون وننتظر حوالي دقيقتان, ثم نقوم بسكب البيض على المقلاة ونقوم بتحركهم قليلا وثانيا نضع الحليب على النار حتى يسخن و ممكن اضافة القليل من السكر "),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('meals'.tr(), style: context.tt.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.padding24,
        physics: BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            Text(
              "وجبات اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
              style: context.tt.titleLarge?.copyWith(color: context.cs.primary),
              textAlign: TextAlign.center,
            ),
            ...List.generate(meals.length, (index) {
              final meal = meals[index];
              return _buildMealItem(meal);
            }),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(MealModel meal) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  meal.name,
                  style: context.tt.titleLarge?.copyWith(
                    color: context.cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...meal.ingredients.map((ingredientWithQnt) {
              final ingredient = ingredientWithQnt.ingredient;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      style: context.tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrient(
                          icon: Icons.local_drink,
                          label: "الكمية",
                          value: ingredientWithQnt.quantity.toString(),
                        ),
                        _buildNutrient(
                          icon: Icons.local_fire_department,
                          label: "السعرات",
                          value: ingredient.calories,
                        ),
                        _buildNutrient(
                          icon: Icons.fitness_center,
                          label: "البروتين",
                          value: ingredient.proteins,
                        ),
                        _buildNutrient(
                          icon: Icons.bubble_chart,
                          label: "الكربوهيدرات",
                          value: ingredient.carbs,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Column(
              children: [
                Padding(
                  padding: AppConstants.paddingH20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("طريقة التحضير :", style: context.tt.titleLarge),
                      Icon(Icons.play_circle, color: context.cs.error)
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(meal.description, style: context.tt.bodyMedium),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
