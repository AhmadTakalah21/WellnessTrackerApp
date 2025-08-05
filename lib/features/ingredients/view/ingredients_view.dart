import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/ingredients/cubit/ingredients_cubit.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/ingredients/view/widgets/add_ingredient_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class IngredientsViewCallbacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  void onTap(IngredientModel ingredient);
  void onEditTap(IngredientModel ingredient);
  void onDeleteTap(IngredientModel ingredient);
  void onAddTap();
}

@RoutePage()
class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<IngredientsCubit>(),
      child: const IngredientsPage(),
    );
  }
}

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage>
    implements IngredientsViewCallbacks {
  late final IngredientsCubit ingredientsCubit = context.read();
  @override
  void initState() {
    super.initState();
    ingredientsCubit.getIngredients(UserRoleEnum.dietitian);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onAddTap() {
    showDialog(
      context: context,
      builder: (_) {
        return AddIngredientView(ingredientsCubit: ingredientsCubit);
      },
    );
  }

  @override
  void onTap(IngredientModel ingredient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: ingredient,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(IngredientModel ingredient) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: ingredient,
          onSuccess: () {
            Navigator.pop(context);
            ingredientsCubit.getIngredients(UserRoleEnum.dietitian);
          }),
    );
  }

  @override
  void onEditTap(IngredientModel ingredient) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) {
        return AddIngredientView(
          ingredientsCubit: ingredientsCubit,
          ingredient: ingredient,
        );
      },
    );
  }

  @override
  void onTryAgainTap() =>
      ingredientsCubit.getIngredients(UserRoleEnum.dietitian);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('ingredients'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<IngredientsCubit, GeneralIngredientsState>(
        buildWhen: (previous, current) => current is IngredientsState,
        builder: (context, state) {
          if (state is IngredientsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is IngredientsSuccess) {
            final ingredients = state.ingredients.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...ingredients.map((ing) => _buildIngredientItem(ing)),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            );
          } else if (state is IngredientsEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is IngredientsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: MainFloatingButton(
        onTap: onAddTap,
      ),
    );
  }

  Widget _buildIngredientItem(IngredientModel ingredient) {
    return InkWell(
      onTap: () => onTap(ingredient),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ingredient.name, style: context.tt.headlineSmall),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNutrient(
                        icon: Icons.local_fire_department,
                        label: "unit",
                        value: ingredient.unit.displayName,
                      ),
                      _buildNutrient(
                        icon: Icons.local_fire_department,
                        label: "calories",
                        value: ingredient.calories,
                      ),
                      _buildNutrient(
                        icon: Icons.fitness_center,
                        label: "proteins",
                        value: ingredient.proteins,
                      ),
                      _buildNutrient(
                        icon: Icons.bubble_chart,
                        label: "carbs",
                        value: ingredient.carbs,
                      ),
                    ],
                  ),
                ],
              ),
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
        Text(label.tr(), style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
