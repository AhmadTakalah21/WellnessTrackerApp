import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../global/models/day_enum.dart';
import '../../../global/di/di.dart';
import '../../meals/model/meal_model/meal_model.dart';
import '../../meals/cubit/meals_cubit.dart';
import '../cubit/meal_plans_cubit.dart';

class AddMealPlanDialog extends StatefulWidget {
  const AddMealPlanDialog({super.key});

  @override
  State<AddMealPlanDialog> createState() => _AddMealPlanDialogState();
}

class _AddMealPlanDialogState extends State<AddMealPlanDialog> {
  final MealPlansCubit mealPlansCubit = get<MealPlansCubit>();
  final MealsCubit mealsCubit = get<MealsCubit>();
  final TextEditingController nameController = TextEditingController();

  final Map<DayEnum, List<MealModel>> selectedMealsByDay = {
    for (final day in DayEnum.values) day: [],
  };

  List<MealModel> allMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    final meals = await mealsCubit.getAllMeals();
    setState(() => allMeals = meals);
  }

  void _openMealSelector(DayEnum day) async {
    final selectedMeals = await showDialog<List<MealModel>>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("select_meals_for".tr(args: [day.displayName])),
          content: SizedBox(
            height: 400,
            width: 350,
            child: MultiSelectDialog<MealModel>(
              items: allMeals
                  .map((meal) => MultiSelectItem(meal, meal.name))
                  .toList(),
              initialValue: selectedMealsByDay[day] ?? [],
              onConfirm: (selected) => Navigator.pop(ctx, selected),
              searchable: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("cancel".tr()),
            )
          ],
        );
      },
    );

    if (selectedMeals != null) {
      setState(() => selectedMealsByDay[day] = selectedMeals);
    }
  }

  Future<void> _onSave() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("meal_plan_name_required".tr())),
      );
      return;
    }

    mealPlansCubit.setName(name);

    for (final entry in selectedMealsByDay.entries) {
      mealPlansCubit.setMealsForDay(
        entry.key.name,
        entry.value.map((meal) => meal.id).toList(),
      );
    }

    mealPlansCubit.setDetailedPlanDays();

    await mealPlansCubit.addMealPlan();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "add_meal_plan".tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "meal_plan_name".tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3.5,
              physics: const NeverScrollableScrollPhysics(),
              children: DayEnum.values.map((day) {
                final selectedCount = selectedMealsByDay[day]?.length ?? 0;
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _openMealSelector(day),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(day.displayName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                if (selectedCount > 0)
                                  Text(
                                    "$selectedCount ${"meals_selected".tr()}",
                                    style:
                                    Theme.of(context).textTheme.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                          const Icon(Icons.add_circle_outline),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("cancel".tr()),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _onSave,
                  child: Text("save".tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
