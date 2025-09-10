import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart';
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/view/widgets/meal_tile.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
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
      appBar: AppBar(title: Text('meals'.tr())),
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
                    ...meals.map((meal) => MealTile(meal: meal, onTap: onTap)),
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
}
