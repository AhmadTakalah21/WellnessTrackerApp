import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart';
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class MealsDietitianViewCallbacks {
  void onAddTap();
  void onTap(MealModel meal);
  void onEditTap(MealModel meal);
  void onDeleteTap(MealModel meal);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class MealsDietitianView extends StatelessWidget {
  const MealsDietitianView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<MealsCubit>(),
      child: const MealsDietitianPage(),
    );
  }
}

class MealsDietitianPage extends StatefulWidget {
  const MealsDietitianPage({super.key});

  @override
  State<MealsDietitianPage> createState() => _MealsDietitianPageState();
}

class _MealsDietitianPageState extends State<MealsDietitianPage>
    implements MealsDietitianViewCallbacks {
  late final MealsCubit mealsCubit = context.read();
  @override
  void initState() {
    super.initState();
    mealsCubit.getMeals();
  }

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealView(mealsCubit: mealsCubit),
      ),
    );
  }

  @override
  void onTap(MealModel meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: meal,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(MealModel meal) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        item: meal,
        onSuccess: () {
          Navigator.pop(context);
          mealsCubit.getMeals();
        },
      ),
    );
  }

  @override
  void onEditTap(MealModel meal) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealView(mealsCubit: mealsCubit, meal: meal),
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => mealsCubit.getMeals();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('meals'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<MealsCubit, GeneralMealsState>(
        buildWhen: (previous, current) => current is MealsState,
        builder: (context, state) {
          if (state is MealsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is MealsSuccess) {
            final meals = state.meals.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...meals.map((meal) => _buildMealItem(meal)),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            );
          } else if (state is MealsEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is MealsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: MainFloatingButton(onTap: onAddTap),
    );
  }

  Widget _buildMealItem(MealModel meal) {
    return InkWell(
      onTap: () => onTap(meal),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: AppConstants.padding20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(meal.name, style: context.tt.headlineSmall),
                ],
              ),
              const SizedBox(height: 16),
              ...meal.ingredients.map((ingredientWithQnt) {
                final ingredient = ingredientWithQnt.ingredient;
                return Container(
                  margin: AppConstants.paddingV10,
                  padding: AppConstants.padding12,
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
              Padding(
                padding: AppConstants.paddingH20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("طريقة التحضير :", style: context.tt.titleLarge),
                        Icon(Icons.play_circle, color: context.cs.error)
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(meal.description, style: context.tt.bodyMedium),
                  ],
                ),
              )
            ],
          ),
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
