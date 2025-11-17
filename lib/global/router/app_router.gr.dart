// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i57;
import 'package:flutter/material.dart' as _i58;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i59;
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart'
    as _i60;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_router.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i80;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i75;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i17;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i29;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i20;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i44;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i47;
import 'package:wellnesstrackerapp/features/auth/view/widgets/verify_code_view.dart'
    as _i55;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i18;
import 'package:wellnesstrackerapp/features/company_info/view/company_info_view.dart'
    as _i19;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i77;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i76;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i22;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i14;
import 'package:wellnesstrackerapp/features/customers/view/widgets/assign_customers_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/customers/view/widgets/subscriber_evaluation_view.dart'
    as _i50;
import 'package:wellnesstrackerapp/features/customers/view/widgets/update_customer_info_view.dart'
    as _i52;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_router.dart'
    as _i23;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i24;
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart'
    as _i61;
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart'
    as _i62;
import 'package:wellnesstrackerapp/features/exercise_plans/view/add_exercise_plan_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/exercise_plans/view/exercise_plans_view.dart'
    as _i26;
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart'
    as _i63;
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart'
    as _i64;
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_coach_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i28;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i30;
import 'package:wellnesstrackerapp/features/ingredients/view/ingredients_view.dart'
    as _i31;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i32;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i65;
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart'
    as _i66;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i33;
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart'
    as _i68;
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart'
    as _i67;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i34;
import 'package:wellnesstrackerapp/features/levels/view/widgets/add_level_widget.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart'
    as _i69;
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart'
    as _i70;
import 'package:wellnesstrackerapp/features/meal_plans/view/add_meal_plans.dart'
    as _i7;
import 'package:wellnesstrackerapp/features/meal_plans/view/meal_plans_view.dart'
    as _i35;
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart'
    as _i71;
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart'
    as _i72;
import 'package:wellnesstrackerapp/features/meals/view/meals_dietitian_view.dart'
    as _i36;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i37;
import 'package:wellnesstrackerapp/features/notifications/view/notifications_view.dart'
    as _i38;
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart'
    as _i73;
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart'
    as _i74;
import 'package:wellnesstrackerapp/features/points/view/pages/current_points_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/points/view/pages/earn_points_ways_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i39;
import 'package:wellnesstrackerapp/features/points/view/widgets/add_points_guideline_widget.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i40;
import 'package:wellnesstrackerapp/features/profile/view/add_rate_view.dart'
    as _i10;
import 'package:wellnesstrackerapp/features/profile/view/profile_router.dart'
    as _i41;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i42;
import 'package:wellnesstrackerapp/features/ratings/view/ratings_view.dart'
    as _i43;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i45;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i46;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i48;
import 'package:wellnesstrackerapp/features/statistics/view/statistics_view.dart'
    as _i49;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i51;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i53;
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart'
    as _i79;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i54;
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart' as _i78;
import 'package:wellnesstrackerapp/global/widgets/video_player_widget.dart'
    as _i56;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i57.PageRouteInfo<void> {
  const AboutUsRoute({List<_i57.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddAdvView]
class AddAdvRoute extends _i57.PageRouteInfo<AddAdvRouteArgs> {
  AddAdvRoute({
    _i58.Key? key,
    required _i59.AddsAndOffersCubit advCubit,
    _i60.AdvModel? adv,
    _i58.VoidCallback? onSuccess,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddAdvRoute.name,
         args: AddAdvRouteArgs(
           key: key,
           advCubit: advCubit,
           adv: adv,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'AddAdvRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddAdvRouteArgs>();
      return _i2.AddAdvView(
        key: args.key,
        advCubit: args.advCubit,
        adv: args.adv,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class AddAdvRouteArgs {
  const AddAdvRouteArgs({
    this.key,
    required this.advCubit,
    this.adv,
    this.onSuccess,
  });

  final _i58.Key? key;

  final _i59.AddsAndOffersCubit advCubit;

  final _i60.AdvModel? adv;

  final _i58.VoidCallback? onSuccess;

  @override
  String toString() {
    return 'AddAdvRouteArgs{key: $key, advCubit: $advCubit, adv: $adv, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddAdvRouteArgs) return false;
    return key == other.key &&
        advCubit == other.advCubit &&
        adv == other.adv &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode =>
      key.hashCode ^ advCubit.hashCode ^ adv.hashCode ^ onSuccess.hashCode;
}

/// generated route for
/// [_i3.AddExercisePlanView]
class AddExercisePlanRoute
    extends _i57.PageRouteInfo<AddExercisePlanRouteArgs> {
  AddExercisePlanRoute({
    _i58.Key? key,
    required _i61.ExercisePlansCubit exercisePlansCubit,
    _i62.ExercisePlanModel? exercisePlan,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddExercisePlanRoute.name,
         args: AddExercisePlanRouteArgs(
           key: key,
           exercisePlansCubit: exercisePlansCubit,
           exercisePlan: exercisePlan,
         ),
         initialChildren: children,
       );

  static const String name = 'AddExercisePlanRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExercisePlanRouteArgs>();
      return _i3.AddExercisePlanView(
        key: args.key,
        exercisePlansCubit: args.exercisePlansCubit,
        exercisePlan: args.exercisePlan,
      );
    },
  );
}

class AddExercisePlanRouteArgs {
  const AddExercisePlanRouteArgs({
    this.key,
    required this.exercisePlansCubit,
    this.exercisePlan,
  });

  final _i58.Key? key;

  final _i61.ExercisePlansCubit exercisePlansCubit;

  final _i62.ExercisePlanModel? exercisePlan;

  @override
  String toString() {
    return 'AddExercisePlanRouteArgs{key: $key, exercisePlansCubit: $exercisePlansCubit, exercisePlan: $exercisePlan}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddExercisePlanRouteArgs) return false;
    return key == other.key &&
        exercisePlansCubit == other.exercisePlansCubit &&
        exercisePlan == other.exercisePlan;
  }

  @override
  int get hashCode =>
      key.hashCode ^ exercisePlansCubit.hashCode ^ exercisePlan.hashCode;
}

/// generated route for
/// [_i4.AddExerciseView]
class AddExerciseRoute extends _i57.PageRouteInfo<AddExerciseRouteArgs> {
  AddExerciseRoute({
    _i58.Key? key,
    required _i63.ExercisesCubit exercisesCubit,
    _i64.ExerciseModel? exercise,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddExerciseRoute.name,
         args: AddExerciseRouteArgs(
           key: key,
           exercisesCubit: exercisesCubit,
           exercise: exercise,
         ),
         initialChildren: children,
       );

  static const String name = 'AddExerciseRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExerciseRouteArgs>();
      return _i4.AddExerciseView(
        key: args.key,
        exercisesCubit: args.exercisesCubit,
        exercise: args.exercise,
      );
    },
  );
}

class AddExerciseRouteArgs {
  const AddExerciseRouteArgs({
    this.key,
    required this.exercisesCubit,
    this.exercise,
  });

  final _i58.Key? key;

  final _i63.ExercisesCubit exercisesCubit;

  final _i64.ExerciseModel? exercise;

  @override
  String toString() {
    return 'AddExerciseRouteArgs{key: $key, exercisesCubit: $exercisesCubit, exercise: $exercise}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddExerciseRouteArgs) return false;
    return key == other.key &&
        exercisesCubit == other.exercisesCubit &&
        exercise == other.exercise;
  }

  @override
  int get hashCode =>
      key.hashCode ^ exercisesCubit.hashCode ^ exercise.hashCode;
}

/// generated route for
/// [_i5.AddItemView]
class AddItemRoute extends _i57.PageRouteInfo<AddItemRouteArgs> {
  AddItemRoute({
    _i58.Key? key,
    required _i65.ItemsCubit itemCubit,
    _i66.ItemModel? item,
    _i58.VoidCallback? onSuccess,
    _i67.LevelModel? level,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddItemRoute.name,
         args: AddItemRouteArgs(
           key: key,
           itemCubit: itemCubit,
           item: item,
           onSuccess: onSuccess,
           level: level,
         ),
         initialChildren: children,
       );

  static const String name = 'AddItemRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddItemRouteArgs>();
      return _i5.AddItemView(
        key: args.key,
        itemCubit: args.itemCubit,
        item: args.item,
        onSuccess: args.onSuccess,
        level: args.level,
      );
    },
  );
}

class AddItemRouteArgs {
  const AddItemRouteArgs({
    this.key,
    required this.itemCubit,
    this.item,
    this.onSuccess,
    this.level,
  });

  final _i58.Key? key;

  final _i65.ItemsCubit itemCubit;

  final _i66.ItemModel? item;

  final _i58.VoidCallback? onSuccess;

  final _i67.LevelModel? level;

  @override
  String toString() {
    return 'AddItemRouteArgs{key: $key, itemCubit: $itemCubit, item: $item, onSuccess: $onSuccess, level: $level}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddItemRouteArgs) return false;
    return key == other.key &&
        itemCubit == other.itemCubit &&
        item == other.item &&
        onSuccess == other.onSuccess &&
        level == other.level;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      itemCubit.hashCode ^
      item.hashCode ^
      onSuccess.hashCode ^
      level.hashCode;
}

/// generated route for
/// [_i6.AddLevelView]
class AddLevelRoute extends _i57.PageRouteInfo<AddLevelRouteArgs> {
  AddLevelRoute({
    _i58.Key? key,
    required _i68.LevelsCubit levelsCubit,
    _i58.VoidCallback? onSuccess,
    _i67.LevelModel? level,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddLevelRoute.name,
         args: AddLevelRouteArgs(
           key: key,
           levelsCubit: levelsCubit,
           onSuccess: onSuccess,
           level: level,
         ),
         initialChildren: children,
       );

  static const String name = 'AddLevelRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddLevelRouteArgs>();
      return _i6.AddLevelView(
        key: args.key,
        levelsCubit: args.levelsCubit,
        onSuccess: args.onSuccess,
        level: args.level,
      );
    },
  );
}

class AddLevelRouteArgs {
  const AddLevelRouteArgs({
    this.key,
    required this.levelsCubit,
    this.onSuccess,
    this.level,
  });

  final _i58.Key? key;

  final _i68.LevelsCubit levelsCubit;

  final _i58.VoidCallback? onSuccess;

  final _i67.LevelModel? level;

  @override
  String toString() {
    return 'AddLevelRouteArgs{key: $key, levelsCubit: $levelsCubit, onSuccess: $onSuccess, level: $level}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddLevelRouteArgs) return false;
    return key == other.key &&
        levelsCubit == other.levelsCubit &&
        onSuccess == other.onSuccess &&
        level == other.level;
  }

  @override
  int get hashCode =>
      key.hashCode ^ levelsCubit.hashCode ^ onSuccess.hashCode ^ level.hashCode;
}

/// generated route for
/// [_i7.AddMealPlanView]
class AddMealPlanRoute extends _i57.PageRouteInfo<AddMealPlanRouteArgs> {
  AddMealPlanRoute({
    _i58.Key? key,
    required _i69.MealPlansCubit mealPlansCubit,
    _i70.MealPlanModel? mealPlan,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddMealPlanRoute.name,
         args: AddMealPlanRouteArgs(
           key: key,
           mealPlansCubit: mealPlansCubit,
           mealPlan: mealPlan,
         ),
         initialChildren: children,
       );

  static const String name = 'AddMealPlanRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMealPlanRouteArgs>();
      return _i7.AddMealPlanView(
        key: args.key,
        mealPlansCubit: args.mealPlansCubit,
        mealPlan: args.mealPlan,
      );
    },
  );
}

class AddMealPlanRouteArgs {
  const AddMealPlanRouteArgs({
    this.key,
    required this.mealPlansCubit,
    this.mealPlan,
  });

  final _i58.Key? key;

  final _i69.MealPlansCubit mealPlansCubit;

  final _i70.MealPlanModel? mealPlan;

  @override
  String toString() {
    return 'AddMealPlanRouteArgs{key: $key, mealPlansCubit: $mealPlansCubit, mealPlan: $mealPlan}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddMealPlanRouteArgs) return false;
    return key == other.key &&
        mealPlansCubit == other.mealPlansCubit &&
        mealPlan == other.mealPlan;
  }

  @override
  int get hashCode =>
      key.hashCode ^ mealPlansCubit.hashCode ^ mealPlan.hashCode;
}

/// generated route for
/// [_i8.AddMealView]
class AddMealRoute extends _i57.PageRouteInfo<AddMealRouteArgs> {
  AddMealRoute({
    _i58.Key? key,
    required _i71.MealsCubit mealsCubit,
    _i72.MealModel? meal,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddMealRoute.name,
         args: AddMealRouteArgs(key: key, mealsCubit: mealsCubit, meal: meal),
         initialChildren: children,
       );

  static const String name = 'AddMealRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMealRouteArgs>();
      return _i8.AddMealView(
        key: args.key,
        mealsCubit: args.mealsCubit,
        meal: args.meal,
      );
    },
  );
}

class AddMealRouteArgs {
  const AddMealRouteArgs({this.key, required this.mealsCubit, this.meal});

  final _i58.Key? key;

  final _i71.MealsCubit mealsCubit;

  final _i72.MealModel? meal;

  @override
  String toString() {
    return 'AddMealRouteArgs{key: $key, mealsCubit: $mealsCubit, meal: $meal}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddMealRouteArgs) return false;
    return key == other.key &&
        mealsCubit == other.mealsCubit &&
        meal == other.meal;
  }

  @override
  int get hashCode => key.hashCode ^ mealsCubit.hashCode ^ meal.hashCode;
}

/// generated route for
/// [_i9.AddPointsGuidelineView]
class AddPointsGuidelineRoute
    extends _i57.PageRouteInfo<AddPointsGuidelineRouteArgs> {
  AddPointsGuidelineRoute({
    _i58.Key? key,
    required _i73.PointsCubit pointsCubit,
    _i74.PointsGuidelineModel? guideline,
    _i58.VoidCallback? onSuccess,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AddPointsGuidelineRoute.name,
         args: AddPointsGuidelineRouteArgs(
           key: key,
           pointsCubit: pointsCubit,
           guideline: guideline,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'AddPointsGuidelineRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPointsGuidelineRouteArgs>();
      return _i9.AddPointsGuidelineView(
        key: args.key,
        pointsCubit: args.pointsCubit,
        guideline: args.guideline,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class AddPointsGuidelineRouteArgs {
  const AddPointsGuidelineRouteArgs({
    this.key,
    required this.pointsCubit,
    this.guideline,
    this.onSuccess,
  });

  final _i58.Key? key;

  final _i73.PointsCubit pointsCubit;

  final _i74.PointsGuidelineModel? guideline;

  final _i58.VoidCallback? onSuccess;

  @override
  String toString() {
    return 'AddPointsGuidelineRouteArgs{key: $key, pointsCubit: $pointsCubit, guideline: $guideline, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddPointsGuidelineRouteArgs) return false;
    return key == other.key &&
        pointsCubit == other.pointsCubit &&
        guideline == other.guideline &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      pointsCubit.hashCode ^
      guideline.hashCode ^
      onSuccess.hashCode;
}

/// generated route for
/// [_i10.AddRateView]
class AddRateRoute extends _i57.PageRouteInfo<void> {
  const AddRateRoute({List<_i57.PageRouteInfo>? children})
    : super(AddRateRoute.name, initialChildren: children);

  static const String name = 'AddRateRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i10.AddRateView();
    },
  );
}

/// generated route for
/// [_i11.AddsAndOffersRouter]
class AddsAndOffersRouter extends _i57.PageRouteInfo<void> {
  const AddsAndOffersRouter({List<_i57.PageRouteInfo>? children})
    : super(AddsAndOffersRouter.name, initialChildren: children);

  static const String name = 'AddsAndOffersRouter';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i11.AddsAndOffersRouter();
    },
  );
}

/// generated route for
/// [_i12.AddsAndOffersView]
class AddsAndOffersRoute extends _i57.PageRouteInfo<void> {
  const AddsAndOffersRoute({List<_i57.PageRouteInfo>? children})
    : super(AddsAndOffersRoute.name, initialChildren: children);

  static const String name = 'AddsAndOffersRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i12.AddsAndOffersView();
    },
  );
}

/// generated route for
/// [_i13.AppManagerView]
class AppManagerRoute extends _i57.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i58.Key? key,
    _i75.SignInModel? user,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AppManagerRoute.name,
         args: AppManagerRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'AppManagerRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>(
        orElse: () => const AppManagerRouteArgs(),
      );
      return _i13.AppManagerView(key: args.key, user: args.user);
    },
  );
}

class AppManagerRouteArgs {
  const AppManagerRouteArgs({this.key, this.user});

  final _i58.Key? key;

  final _i75.SignInModel? user;

  @override
  String toString() {
    return 'AppManagerRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppManagerRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
}

/// generated route for
/// [_i14.ApproveCustomerView]
class ApproveCustomerRoute
    extends _i57.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i58.Key? key,
    required _i76.CustomerModel customer,
    required _i77.CustomersCubit customersCubit,
    _i58.VoidCallback? onSuccess,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ApproveCustomerRoute.name,
         args: ApproveCustomerRouteArgs(
           key: key,
           customer: customer,
           customersCubit: customersCubit,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'ApproveCustomerRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApproveCustomerRouteArgs>();
      return _i14.ApproveCustomerView(
        key: args.key,
        customer: args.customer,
        customersCubit: args.customersCubit,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class ApproveCustomerRouteArgs {
  const ApproveCustomerRouteArgs({
    this.key,
    required this.customer,
    required this.customersCubit,
    this.onSuccess,
  });

  final _i58.Key? key;

  final _i76.CustomerModel customer;

  final _i77.CustomersCubit customersCubit;

  final _i58.VoidCallback? onSuccess;

  @override
  String toString() {
    return 'ApproveCustomerRouteArgs{key: $key, customer: $customer, customersCubit: $customersCubit, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ApproveCustomerRouteArgs) return false;
    return key == other.key &&
        customer == other.customer &&
        customersCubit == other.customersCubit &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      customer.hashCode ^
      customersCubit.hashCode ^
      onSuccess.hashCode;
}

/// generated route for
/// [_i15.AssignCustomersView]
class AssignCustomersRoute
    extends _i57.PageRouteInfo<AssignCustomersRouteArgs> {
  AssignCustomersRoute({
    _i58.Key? key,
    required _i77.CustomersCubit customersCubit,
    _i58.VoidCallback? onSuccess,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         AssignCustomersRoute.name,
         args: AssignCustomersRouteArgs(
           key: key,
           customersCubit: customersCubit,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'AssignCustomersRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AssignCustomersRouteArgs>();
      return _i15.AssignCustomersView(
        key: args.key,
        customersCubit: args.customersCubit,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class AssignCustomersRouteArgs {
  const AssignCustomersRouteArgs({
    this.key,
    required this.customersCubit,
    this.onSuccess,
  });

  final _i58.Key? key;

  final _i77.CustomersCubit customersCubit;

  final _i58.VoidCallback? onSuccess;

  @override
  String toString() {
    return 'AssignCustomersRouteArgs{key: $key, customersCubit: $customersCubit, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AssignCustomersRouteArgs) return false;
    return key == other.key &&
        customersCubit == other.customersCubit &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode =>
      key.hashCode ^ customersCubit.hashCode ^ onSuccess.hashCode;
}

/// generated route for
/// [_i16.AuthManagerView]
class AuthManagerRoute extends _i57.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i57.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i16.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i17.AuthRouterPage]
class AuthRouter extends _i57.PageRouteInfo<void> {
  const AuthRouter({List<_i57.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i17.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i18.CodesView]
class CodesRoute extends _i57.PageRouteInfo<void> {
  const CodesRoute({List<_i57.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i18.CodesView();
    },
  );
}

/// generated route for
/// [_i19.CompanyInfoView]
class CompanyInfoRoute extends _i57.PageRouteInfo<CompanyInfoRouteArgs> {
  CompanyInfoRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         CompanyInfoRoute.name,
         args: CompanyInfoRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'CompanyInfoRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyInfoRouteArgs>();
      return _i19.CompanyInfoView(key: args.key, role: args.role);
    },
  );
}

class CompanyInfoRouteArgs {
  const CompanyInfoRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'CompanyInfoRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyInfoRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i20.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i57.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i57.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i20.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i21.CurrentPointsView]
class CurrentPointsRoute extends _i57.PageRouteInfo<void> {
  const CurrentPointsRoute({List<_i57.PageRouteInfo>? children})
    : super(CurrentPointsRoute.name, initialChildren: children);

  static const String name = 'CurrentPointsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i21.CurrentPointsView();
    },
  );
}

/// generated route for
/// [_i22.CustomersView]
class CustomersRoute extends _i57.PageRouteInfo<CustomersRouteArgs> {
  CustomersRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    _i79.UserModel? user,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         CustomersRoute.name,
         args: CustomersRouteArgs(key: key, role: role, user: user),
         initialChildren: children,
       );

  static const String name = 'CustomersRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomersRouteArgs>();
      return _i22.CustomersView(
        key: args.key,
        role: args.role,
        user: args.user,
      );
    },
  );
}

class CustomersRouteArgs {
  const CustomersRouteArgs({this.key, required this.role, this.user});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  final _i79.UserModel? user;

  @override
  String toString() {
    return 'CustomersRouteArgs{key: $key, role: $role, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomersRouteArgs) return false;
    return key == other.key && role == other.role && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode ^ user.hashCode;
}

/// generated route for
/// [_i23.DashboardRouter]
class DashboardRouter extends _i57.PageRouteInfo<void> {
  const DashboardRouter({List<_i57.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i23.DashboardRouter();
    },
  );
}

/// generated route for
/// [_i24.DashboardView]
class DashboardRoute extends _i57.PageRouteInfo<void> {
  const DashboardRoute({List<_i57.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i24.DashboardView();
    },
  );
}

/// generated route for
/// [_i25.EarnPointsWaysView]
class EarnPointsWaysRoute extends _i57.PageRouteInfo<EarnPointsWaysRouteArgs> {
  EarnPointsWaysRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         EarnPointsWaysRoute.name,
         args: EarnPointsWaysRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'EarnPointsWaysRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EarnPointsWaysRouteArgs>();
      return _i25.EarnPointsWaysView(key: args.key, role: args.role);
    },
  );
}

class EarnPointsWaysRouteArgs {
  const EarnPointsWaysRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'EarnPointsWaysRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EarnPointsWaysRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i26.ExercisePlansView]
class ExercisePlansRoute extends _i57.PageRouteInfo<void> {
  const ExercisePlansRoute({List<_i57.PageRouteInfo>? children})
    : super(ExercisePlansRoute.name, initialChildren: children);

  static const String name = 'ExercisePlansRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i26.ExercisePlansView();
    },
  );
}

/// generated route for
/// [_i27.ExercisesCoachView]
class ExercisesCoachRoute extends _i57.PageRouteInfo<ExercisesCoachRouteArgs> {
  ExercisesCoachRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ExercisesCoachRoute.name,
         args: ExercisesCoachRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'ExercisesCoachRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisesCoachRouteArgs>();
      return _i27.ExercisesCoachView(key: args.key, role: args.role);
    },
  );
}

class ExercisesCoachRouteArgs {
  const ExercisesCoachRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'ExercisesCoachRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExercisesCoachRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i28.ExercisesView]
class ExercisesRoute extends _i57.PageRouteInfo<ExercisesRouteArgs> {
  ExercisesRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ExercisesRoute.name,
         args: ExercisesRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'ExercisesRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisesRouteArgs>();
      return _i28.ExercisesView(key: args.key, role: args.role);
    },
  );
}

class ExercisesRouteArgs {
  const ExercisesRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'ExercisesRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExercisesRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i29.ForgotPasswordView]
class ForgotPasswordRoute extends _i57.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i58.Key? key,
    required _i80.AuthCubit authCubit,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i29.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i58.Key? key;

  final _i80.AuthCubit authCubit;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key, authCubit: $authCubit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForgotPasswordRouteArgs) return false;
    return key == other.key && authCubit == other.authCubit;
  }

  @override
  int get hashCode => key.hashCode ^ authCubit.hashCode;
}

/// generated route for
/// [_i30.HealthAssesmentView]
class HealthAssesmentRoute extends _i57.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i57.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i30.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i31.IngredientsView]
class IngredientsRoute extends _i57.PageRouteInfo<void> {
  const IngredientsRoute({List<_i57.PageRouteInfo>? children})
    : super(IngredientsRoute.name, initialChildren: children);

  static const String name = 'IngredientsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i31.IngredientsView();
    },
  );
}

/// generated route for
/// [_i32.IntroView]
class IntroRoute extends _i57.PageRouteInfo<void> {
  const IntroRoute({List<_i57.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i32.IntroView();
    },
  );
}

/// generated route for
/// [_i33.ItemsView]
class ItemsRoute extends _i57.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    _i67.LevelModel? level,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, role: role, level: level),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>();
      return _i33.ItemsView(key: args.key, role: args.role, level: args.level);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, required this.role, this.level});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  final _i67.LevelModel? level;

  @override
  String toString() {
    return 'ItemsRouteArgs{key: $key, role: $role, level: $level}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemsRouteArgs) return false;
    return key == other.key && role == other.role && level == other.level;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode ^ level.hashCode;
}

/// generated route for
/// [_i34.LevelsView]
class LevelsRoute extends _i57.PageRouteInfo<LevelsRouteArgs> {
  LevelsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         LevelsRoute.name,
         args: LevelsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'LevelsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LevelsRouteArgs>();
      return _i34.LevelsView(key: args.key, role: args.role);
    },
  );
}

class LevelsRouteArgs {
  const LevelsRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'LevelsRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LevelsRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i35.MealPlansView]
class MealPlansRoute extends _i57.PageRouteInfo<void> {
  const MealPlansRoute({List<_i57.PageRouteInfo>? children})
    : super(MealPlansRoute.name, initialChildren: children);

  static const String name = 'MealPlansRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i35.MealPlansView();
    },
  );
}

/// generated route for
/// [_i36.MealsDietitianView]
class MealsDietitianRoute extends _i57.PageRouteInfo<void> {
  const MealsDietitianRoute({List<_i57.PageRouteInfo>? children})
    : super(MealsDietitianRoute.name, initialChildren: children);

  static const String name = 'MealsDietitianRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i36.MealsDietitianView();
    },
  );
}

/// generated route for
/// [_i37.MealsView]
class MealsRoute extends _i57.PageRouteInfo<MealsRouteArgs> {
  MealsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         MealsRoute.name,
         args: MealsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'MealsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealsRouteArgs>();
      return _i37.MealsView(key: args.key, role: args.role);
    },
  );
}

class MealsRouteArgs {
  const MealsRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'MealsRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MealsRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i38.NotificationsView]
class NotificationsRoute extends _i57.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         NotificationsRoute.name,
         args: NotificationsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'NotificationsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i38.NotificationsView(key: args.key, role: args.role);
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'NotificationsRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationsRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i39.PointsView]
class PointsRoute extends _i57.PageRouteInfo<PointsRouteArgs> {
  PointsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         PointsRoute.name,
         args: PointsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'PointsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PointsRouteArgs>();
      return _i39.PointsView(key: args.key, role: args.role);
    },
  );
}

class PointsRouteArgs {
  const PointsRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'PointsRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PointsRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i40.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i57.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i57.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i40.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i41.ProfileRouter]
class ProfileRouter extends _i57.PageRouteInfo<void> {
  const ProfileRouter({List<_i57.PageRouteInfo>? children})
    : super(ProfileRouter.name, initialChildren: children);

  static const String name = 'ProfileRouter';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i41.ProfileRouter();
    },
  );
}

/// generated route for
/// [_i42.ProfileView]
class ProfileRoute extends _i57.PageRouteInfo<void> {
  const ProfileRoute({List<_i57.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i42.ProfileView();
    },
  );
}

/// generated route for
/// [_i43.RatingsView]
class RatingsRoute extends _i57.PageRouteInfo<void> {
  const RatingsRoute({List<_i57.PageRouteInfo>? children})
    : super(RatingsRoute.name, initialChildren: children);

  static const String name = 'RatingsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i43.RatingsView();
    },
  );
}

/// generated route for
/// [_i44.ResetPasswordView]
class ResetPasswordRoute extends _i57.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i58.Key? key,
    required _i80.AuthCubit authCubit,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i44.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i58.Key? key;

  final _i80.AuthCubit authCubit;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, authCubit: $authCubit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return key == other.key && authCubit == other.authCubit;
  }

  @override
  int get hashCode => key.hashCode ^ authCubit.hashCode;
}

/// generated route for
/// [_i45.SelectPlanView]
class SelectPlanRoute extends _i57.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i57.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i45.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i46.SettingsView]
class SettingsRoute extends _i57.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>();
      return _i46.SettingsView(key: args.key, role: args.role);
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, required this.role});

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SettingsRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i47.SignInView]
class SignInRoute extends _i57.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i58.Key? key,
    _i58.VoidCallback? onSignedIn,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i47.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i58.Key? key;

  final _i58.VoidCallback? onSignedIn;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, onSignedIn: $onSignedIn}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignInRouteArgs) return false;
    return key == other.key && onSignedIn == other.onSignedIn;
  }

  @override
  int get hashCode => key.hashCode ^ onSignedIn.hashCode;
}

/// generated route for
/// [_i48.SplashView]
class SplashRoute extends _i57.PageRouteInfo<void> {
  const SplashRoute({List<_i57.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i48.SplashView();
    },
  );
}

/// generated route for
/// [_i49.StatisticsView]
class StatisticsRoute extends _i57.PageRouteInfo<void> {
  const StatisticsRoute({List<_i57.PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i49.StatisticsView();
    },
  );
}

/// generated route for
/// [_i50.SubscriberEvaluationView]
class SubscriberEvaluationRoute
    extends _i57.PageRouteInfo<SubscriberEvaluationRouteArgs> {
  SubscriberEvaluationRoute({
    _i58.Key? key,
    required _i78.UserRoleEnum role,
    required _i76.CustomerModel customer,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         SubscriberEvaluationRoute.name,
         args: SubscriberEvaluationRouteArgs(
           key: key,
           role: role,
           customer: customer,
         ),
         initialChildren: children,
       );

  static const String name = 'SubscriberEvaluationRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubscriberEvaluationRouteArgs>();
      return _i50.SubscriberEvaluationView(
        key: args.key,
        role: args.role,
        customer: args.customer,
      );
    },
  );
}

class SubscriberEvaluationRouteArgs {
  const SubscriberEvaluationRouteArgs({
    this.key,
    required this.role,
    required this.customer,
  });

  final _i58.Key? key;

  final _i78.UserRoleEnum role;

  final _i76.CustomerModel customer;

  @override
  String toString() {
    return 'SubscriberEvaluationRouteArgs{key: $key, role: $role, customer: $customer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubscriberEvaluationRouteArgs) return false;
    return key == other.key && role == other.role && customer == other.customer;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode ^ customer.hashCode;
}

/// generated route for
/// [_i51.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i57.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i57.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i51.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i52.UpdateCustomerInfoView]
class UpdateCustomerInfoRoute
    extends _i57.PageRouteInfo<UpdateCustomerInfoRouteArgs> {
  UpdateCustomerInfoRoute({
    _i58.Key? key,
    required _i77.CustomersCubit customersCubit,
    required _i76.CustomerModel customer,
    required _i78.UserRoleEnum role,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         UpdateCustomerInfoRoute.name,
         args: UpdateCustomerInfoRouteArgs(
           key: key,
           customersCubit: customersCubit,
           customer: customer,
           role: role,
         ),
         initialChildren: children,
       );

  static const String name = 'UpdateCustomerInfoRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateCustomerInfoRouteArgs>();
      return _i52.UpdateCustomerInfoView(
        key: args.key,
        customersCubit: args.customersCubit,
        customer: args.customer,
        role: args.role,
      );
    },
  );
}

class UpdateCustomerInfoRouteArgs {
  const UpdateCustomerInfoRouteArgs({
    this.key,
    required this.customersCubit,
    required this.customer,
    required this.role,
  });

  final _i58.Key? key;

  final _i77.CustomersCubit customersCubit;

  final _i76.CustomerModel customer;

  final _i78.UserRoleEnum role;

  @override
  String toString() {
    return 'UpdateCustomerInfoRouteArgs{key: $key, customersCubit: $customersCubit, customer: $customer, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UpdateCustomerInfoRouteArgs) return false;
    return key == other.key &&
        customersCubit == other.customersCubit &&
        customer == other.customer &&
        role == other.role;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      customersCubit.hashCode ^
      customer.hashCode ^
      role.hashCode;
}

/// generated route for
/// [_i53.UserNavigationView]
class UserNavigationRoute extends _i57.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i57.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i53.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i54.UsersView]
class UsersRoute extends _i57.PageRouteInfo<void> {
  const UsersRoute({List<_i57.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      return const _i54.UsersView();
    },
  );
}

/// generated route for
/// [_i55.VerifyResetCodeView]
class VerifyResetCodeRoute
    extends _i57.PageRouteInfo<VerifyResetCodeRouteArgs> {
  VerifyResetCodeRoute({
    _i58.Key? key,
    required _i80.AuthCubit authCubit,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         VerifyResetCodeRoute.name,
         args: VerifyResetCodeRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'VerifyResetCodeRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyResetCodeRouteArgs>();
      return _i55.VerifyResetCodeView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class VerifyResetCodeRouteArgs {
  const VerifyResetCodeRouteArgs({this.key, required this.authCubit});

  final _i58.Key? key;

  final _i80.AuthCubit authCubit;

  @override
  String toString() {
    return 'VerifyResetCodeRouteArgs{key: $key, authCubit: $authCubit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerifyResetCodeRouteArgs) return false;
    return key == other.key && authCubit == other.authCubit;
  }

  @override
  int get hashCode => key.hashCode ^ authCubit.hashCode;
}

/// generated route for
/// [_i56.VideoPlayerView]
class VideoPlayerRoute extends _i57.PageRouteInfo<VideoPlayerRouteArgs> {
  VideoPlayerRoute({
    _i58.Key? key,
    required String url,
    List<_i57.PageRouteInfo>? children,
  }) : super(
         VideoPlayerRoute.name,
         args: VideoPlayerRouteArgs(key: key, url: url),
         initialChildren: children,
       );

  static const String name = 'VideoPlayerRoute';

  static _i57.PageInfo page = _i57.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPlayerRouteArgs>();
      return _i56.VideoPlayerView(key: args.key, url: args.url);
    },
  );
}

class VideoPlayerRouteArgs {
  const VideoPlayerRouteArgs({this.key, required this.url});

  final _i58.Key? key;

  final String url;

  @override
  String toString() {
    return 'VideoPlayerRouteArgs{key: $key, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPlayerRouteArgs) return false;
    return key == other.key && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ url.hashCode;
}
