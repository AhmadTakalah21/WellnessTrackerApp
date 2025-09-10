import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/meals/view/nutrient_tile.dart';

class NutrientsWidget extends StatelessWidget {
  const NutrientsWidget({super.key, required this.ingredient, this.quantity});

  final IngredientModel ingredient;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    final label1 = quantity == null ? "unit" : "amount";
    final icon1 =
        quantity == null ? Icons.local_fire_department : Icons.local_drink;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NutrientTile(
          icon: icon1,
          label: label1,
          value: "${quantity ?? ""} ${ingredient.unit.displayName}",
        ),
        NutrientTile(
          icon: Icons.local_fire_department,
          label: "calories",
          value: ingredient.calories,
        ),
        NutrientTile(
          icon: Icons.fitness_center,
          label: "proteins",
          value: ingredient.proteins,
        ),
        NutrientTile(
          icon: Icons.bubble_chart,
          label: "carbs",
          value: ingredient.carbs,
        ),
      ],
    );
  }
}
