import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart';
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
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) {
        final size = MediaQuery.of(ctx).size;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width > 500 ? 500 : size.width * 0.95,
              maxHeight: size.height * 0.85,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "select_meals_for".tr(args: [day.displayName]),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MultiSelectDialogField<MealModel>(
                        items: allMeals
                            .map((meal) => MultiSelectItem(meal, meal.name))
                            .toList(),
                        initialValue: selectedMealsByDay[day] ?? [],
                        searchable: true,
                        dialogHeight: 300,
                        onConfirm: (selected) => Navigator.pop(ctx, selected),
                        decoration: const BoxDecoration(), // removes inner border
                        chipDisplay: MultiSelectChipDisplay.none(),
                        buttonText: Text(
                          "choose_meals".tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          final newMeal = await showDialog<MealModel>(
                            context: context,
                            builder: (_) => const AddMealDialog(),
                          );
                          if (newMeal != null) {
                            setState(() {
                              allMeals.add(newMeal);
                              selectedMealsByDay[day]?.add(newMeal);
                            });
                          }
                          _openMealSelector(day);
                        },
                        icon: const Icon(Icons.add, color: Colors.teal),
                        label: Text("add_meal".tr(), style: const TextStyle(color: Colors.teal)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text("cancel".tr()),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              final selected = selectedMealsByDay[day] ?? [];
                              Navigator.pop(ctx, selected);
                            },
                            icon: const Icon(Icons.check),
                            label: Text(
                              "save".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
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
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.all(40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height * 0.9,
          maxWidth: 760,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "add_meal_plan".tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "meal_plan_name".tr(),
                  prefixIcon: const Icon(Icons.edit_note_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                "choose_meals_days".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 18,
                runSpacing: 18,
                children: DayEnum.values.map((day) {
                  final selectedCount = selectedMealsByDay[day]?.length ?? 0;
                  return InkWell(
                    onTap: () => _openMealSelector(day),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 330,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 24, color: Colors.teal),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  day.displayName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                if (selectedCount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      "$selectedCount ${"meals_selected".tr()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.grey[700]),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.teal),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: Text("cancel".tr()),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _onSave,
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text("save".tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
