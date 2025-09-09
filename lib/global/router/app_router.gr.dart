// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i53;
import 'package:flutter/material.dart' as _i54;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i55;
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart'
    as _i56;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_router.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i76;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i71;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i16;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i19;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i41;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i44;
import 'package:wellnesstrackerapp/features/auth/view/widgets/verify_code_view.dart'
    as _i52;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i17;
import 'package:wellnesstrackerapp/features/company_info/view/company_info_view.dart'
    as _i18;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i73;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i72;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i14;
import 'package:wellnesstrackerapp/features/customers/view/widgets/subscriber_evaluation_view.dart'
    as _i47;
import 'package:wellnesstrackerapp/features/customers/view/widgets/update_customer_info_view.dart'
    as _i49;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_router.dart'
    as _i22;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i23;
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart'
    as _i57;
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart'
    as _i58;
import 'package:wellnesstrackerapp/features/exercise_plans/view/add_exercise_plan_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart'
    as _i59;
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart'
    as _i60;
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_coach_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i26;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i28;
import 'package:wellnesstrackerapp/features/ingredients/view/ingredients_view.dart'
    as _i29;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i30;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i61;
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart'
    as _i62;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i31;
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart'
    as _i64;
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart'
    as _i63;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i32;
import 'package:wellnesstrackerapp/features/levels/view/widgets/add_level_widget.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart'
    as _i65;
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart'
    as _i66;
import 'package:wellnesstrackerapp/features/meal_plans/view/add_meal_plans.dart'
    as _i7;
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart'
    as _i67;
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart'
    as _i68;
import 'package:wellnesstrackerapp/features/meals/view/meals_dietitian_view.dart'
    as _i33;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i34;
import 'package:wellnesstrackerapp/features/notifications/view/notifications_view.dart'
    as _i35;
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart'
    as _i69;
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart'
    as _i70;
import 'package:wellnesstrackerapp/features/points/view/pages/current_points_view.dart'
    as _i20;
import 'package:wellnesstrackerapp/features/points/view/pages/earn_points_ways_view.dart'
    as _i24;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i36;
import 'package:wellnesstrackerapp/features/points/view/widgets/add_points_guideline_widget.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i37;
import 'package:wellnesstrackerapp/features/profile/view/add_rate_view.dart'
    as _i10;
import 'package:wellnesstrackerapp/features/profile/view/profile_router.dart'
    as _i38;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i39;
import 'package:wellnesstrackerapp/features/ratings/view/ratings_view.dart'
    as _i40;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i42;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i43;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i45;
import 'package:wellnesstrackerapp/features/statistics/view/statistics_view.dart'
    as _i46;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i48;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i50;
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart'
    as _i75;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i51;
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart' as _i74;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i53.PageRouteInfo<void> {
  const AboutUsRoute({List<_i53.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddAdvView]
class AddAdvRoute extends _i53.PageRouteInfo<AddAdvRouteArgs> {
  AddAdvRoute({
    _i54.Key? key,
    required _i55.AddsAndOffersCubit advCubit,
    _i56.AdvModel? adv,
    _i54.VoidCallback? onSuccess,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i55.AddsAndOffersCubit advCubit;

  final _i56.AdvModel? adv;

  final _i54.VoidCallback? onSuccess;

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
    extends _i53.PageRouteInfo<AddExercisePlanRouteArgs> {
  AddExercisePlanRoute({
    _i54.Key? key,
    required _i57.ExercisePlansCubit exercisePlansCubit,
    _i58.ExercisePlanModel? exercisePlan,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i57.ExercisePlansCubit exercisePlansCubit;

  final _i58.ExercisePlanModel? exercisePlan;

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
class AddExerciseRoute extends _i53.PageRouteInfo<AddExerciseRouteArgs> {
  AddExerciseRoute({
    _i54.Key? key,
    required _i59.ExercisesCubit exercisesCubit,
    _i60.ExerciseModel? exercise,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i59.ExercisesCubit exercisesCubit;

  final _i60.ExerciseModel? exercise;

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
class AddItemRoute extends _i53.PageRouteInfo<AddItemRouteArgs> {
  AddItemRoute({
    _i54.Key? key,
    required _i61.ItemsCubit itemCubit,
    _i62.ItemModel? item,
    _i54.VoidCallback? onSuccess,
    _i63.LevelModel? level,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i61.ItemsCubit itemCubit;

  final _i62.ItemModel? item;

  final _i54.VoidCallback? onSuccess;

  final _i63.LevelModel? level;

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
class AddLevelRoute extends _i53.PageRouteInfo<AddLevelRouteArgs> {
  AddLevelRoute({
    _i54.Key? key,
    required _i64.LevelsCubit levelsCubit,
    _i54.VoidCallback? onSuccess,
    _i63.LevelModel? level,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i64.LevelsCubit levelsCubit;

  final _i54.VoidCallback? onSuccess;

  final _i63.LevelModel? level;

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
class AddMealPlanRoute extends _i53.PageRouteInfo<AddMealPlanRouteArgs> {
  AddMealPlanRoute({
    _i54.Key? key,
    required _i65.MealPlansCubit mealPlansCubit,
    _i66.MealPlanModel? mealPlan,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i65.MealPlansCubit mealPlansCubit;

  final _i66.MealPlanModel? mealPlan;

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
class AddMealRoute extends _i53.PageRouteInfo<AddMealRouteArgs> {
  AddMealRoute({
    _i54.Key? key,
    required _i67.MealsCubit mealsCubit,
    _i68.MealModel? meal,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         AddMealRoute.name,
         args: AddMealRouteArgs(key: key, mealsCubit: mealsCubit, meal: meal),
         initialChildren: children,
       );

  static const String name = 'AddMealRoute';

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i67.MealsCubit mealsCubit;

  final _i68.MealModel? meal;

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
    extends _i53.PageRouteInfo<AddPointsGuidelineRouteArgs> {
  AddPointsGuidelineRoute({
    _i54.Key? key,
    required _i69.PointsCubit pointsCubit,
    _i70.PointsGuidelineModel? guideline,
    _i54.VoidCallback? onSuccess,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i69.PointsCubit pointsCubit;

  final _i70.PointsGuidelineModel? guideline;

  final _i54.VoidCallback? onSuccess;

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
class AddRateRoute extends _i53.PageRouteInfo<void> {
  const AddRateRoute({List<_i53.PageRouteInfo>? children})
    : super(AddRateRoute.name, initialChildren: children);

  static const String name = 'AddRateRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i10.AddRateView();
    },
  );
}

/// generated route for
/// [_i11.AddsAndOffersRouter]
class AddsAndOffersRouter extends _i53.PageRouteInfo<void> {
  const AddsAndOffersRouter({List<_i53.PageRouteInfo>? children})
    : super(AddsAndOffersRouter.name, initialChildren: children);

  static const String name = 'AddsAndOffersRouter';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i11.AddsAndOffersRouter();
    },
  );
}

/// generated route for
/// [_i12.AddsAndOffersView]
class AddsAndOffersRoute extends _i53.PageRouteInfo<void> {
  const AddsAndOffersRoute({List<_i53.PageRouteInfo>? children})
    : super(AddsAndOffersRoute.name, initialChildren: children);

  static const String name = 'AddsAndOffersRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i12.AddsAndOffersView();
    },
  );
}

/// generated route for
/// [_i13.AppManagerView]
class AppManagerRoute extends _i53.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i54.Key? key,
    required _i71.SignInModel user,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         AppManagerRoute.name,
         args: AppManagerRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'AppManagerRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i13.AppManagerView(key: args.key, user: args.user);
    },
  );
}

class AppManagerRouteArgs {
  const AppManagerRouteArgs({this.key, required this.user});

  final _i54.Key? key;

  final _i71.SignInModel user;

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
    extends _i53.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i54.Key? key,
    required _i72.CustomerModel customer,
    required _i73.CustomersCubit customersCubit,
    _i54.VoidCallback? onSuccess,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
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

  final _i54.Key? key;

  final _i72.CustomerModel customer;

  final _i73.CustomersCubit customersCubit;

  final _i54.VoidCallback? onSuccess;

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
/// [_i15.AuthManagerView]
class AuthManagerRoute extends _i53.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i53.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i15.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i16.AuthRouterPage]
class AuthRouter extends _i53.PageRouteInfo<void> {
  const AuthRouter({List<_i53.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i16.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i17.CodesView]
class CodesRoute extends _i53.PageRouteInfo<void> {
  const CodesRoute({List<_i53.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i17.CodesView();
    },
  );
}

/// generated route for
/// [_i18.CompanyInfoView]
class CompanyInfoRoute extends _i53.PageRouteInfo<CompanyInfoRouteArgs> {
  CompanyInfoRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         CompanyInfoRoute.name,
         args: CompanyInfoRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'CompanyInfoRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyInfoRouteArgs>();
      return _i18.CompanyInfoView(key: args.key, role: args.role);
    },
  );
}

class CompanyInfoRouteArgs {
  const CompanyInfoRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i19.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i53.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i53.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i19.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i20.CurrentPointsView]
class CurrentPointsRoute extends _i53.PageRouteInfo<void> {
  const CurrentPointsRoute({List<_i53.PageRouteInfo>? children})
    : super(CurrentPointsRoute.name, initialChildren: children);

  static const String name = 'CurrentPointsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i20.CurrentPointsView();
    },
  );
}

/// generated route for
/// [_i21.CustomersView]
class CustomersRoute extends _i53.PageRouteInfo<CustomersRouteArgs> {
  CustomersRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    _i75.UserModel? user,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         CustomersRoute.name,
         args: CustomersRouteArgs(key: key, role: role, user: user),
         initialChildren: children,
       );

  static const String name = 'CustomersRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomersRouteArgs>();
      return _i21.CustomersView(
        key: args.key,
        role: args.role,
        user: args.user,
      );
    },
  );
}

class CustomersRouteArgs {
  const CustomersRouteArgs({this.key, required this.role, this.user});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

  final _i75.UserModel? user;

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
/// [_i22.DashboardRouter]
class DashboardRouter extends _i53.PageRouteInfo<void> {
  const DashboardRouter({List<_i53.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i22.DashboardRouter();
    },
  );
}

/// generated route for
/// [_i23.DashboardView]
class DashboardRoute extends _i53.PageRouteInfo<void> {
  const DashboardRoute({List<_i53.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i23.DashboardView();
    },
  );
}

/// generated route for
/// [_i24.EarnPointsWaysView]
class EarnPointsWaysRoute extends _i53.PageRouteInfo<EarnPointsWaysRouteArgs> {
  EarnPointsWaysRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         EarnPointsWaysRoute.name,
         args: EarnPointsWaysRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'EarnPointsWaysRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EarnPointsWaysRouteArgs>();
      return _i24.EarnPointsWaysView(key: args.key, role: args.role);
    },
  );
}

class EarnPointsWaysRouteArgs {
  const EarnPointsWaysRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i25.ExercisesCoachView]
class ExercisesCoachRoute extends _i53.PageRouteInfo<ExercisesCoachRouteArgs> {
  ExercisesCoachRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ExercisesCoachRoute.name,
         args: ExercisesCoachRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'ExercisesCoachRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisesCoachRouteArgs>();
      return _i25.ExercisesCoachView(key: args.key, role: args.role);
    },
  );
}

class ExercisesCoachRouteArgs {
  const ExercisesCoachRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i26.ExercisesView]
class ExercisesRoute extends _i53.PageRouteInfo<ExercisesRouteArgs> {
  ExercisesRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ExercisesRoute.name,
         args: ExercisesRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'ExercisesRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisesRouteArgs>();
      return _i26.ExercisesView(key: args.key, role: args.role);
    },
  );
}

class ExercisesRouteArgs {
  const ExercisesRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i27.ForgotPasswordView]
class ForgotPasswordRoute extends _i53.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i54.Key? key,
    required _i76.AuthCubit authCubit,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i27.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i54.Key? key;

  final _i76.AuthCubit authCubit;

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
/// [_i28.HealthAssesmentView]
class HealthAssesmentRoute extends _i53.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i53.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i28.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i29.IngredientsView]
class IngredientsRoute extends _i53.PageRouteInfo<void> {
  const IngredientsRoute({List<_i53.PageRouteInfo>? children})
    : super(IngredientsRoute.name, initialChildren: children);

  static const String name = 'IngredientsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i29.IngredientsView();
    },
  );
}

/// generated route for
/// [_i30.IntroView]
class IntroRoute extends _i53.PageRouteInfo<void> {
  const IntroRoute({List<_i53.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i30.IntroView();
    },
  );
}

/// generated route for
/// [_i31.ItemsView]
class ItemsRoute extends _i53.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    _i63.LevelModel? level,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, role: role, level: level),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>();
      return _i31.ItemsView(key: args.key, role: args.role, level: args.level);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, required this.role, this.level});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

  final _i63.LevelModel? level;

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
/// [_i32.LevelsView]
class LevelsRoute extends _i53.PageRouteInfo<LevelsRouteArgs> {
  LevelsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         LevelsRoute.name,
         args: LevelsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'LevelsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LevelsRouteArgs>();
      return _i32.LevelsView(key: args.key, role: args.role);
    },
  );
}

class LevelsRouteArgs {
  const LevelsRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i33.MealsDietitianView]
class MealsDietitianRoute extends _i53.PageRouteInfo<void> {
  const MealsDietitianRoute({List<_i53.PageRouteInfo>? children})
    : super(MealsDietitianRoute.name, initialChildren: children);

  static const String name = 'MealsDietitianRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i33.MealsDietitianView();
    },
  );
}

/// generated route for
/// [_i34.MealsView]
class MealsRoute extends _i53.PageRouteInfo<MealsRouteArgs> {
  MealsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         MealsRoute.name,
         args: MealsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'MealsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealsRouteArgs>();
      return _i34.MealsView(key: args.key, role: args.role);
    },
  );
}

class MealsRouteArgs {
  const MealsRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i35.NotificationsView]
class NotificationsRoute extends _i53.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         NotificationsRoute.name,
         args: NotificationsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'NotificationsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i35.NotificationsView(key: args.key, role: args.role);
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i36.PointsView]
class PointsRoute extends _i53.PageRouteInfo<PointsRouteArgs> {
  PointsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PointsRoute.name,
         args: PointsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'PointsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PointsRouteArgs>();
      return _i36.PointsView(key: args.key, role: args.role);
    },
  );
}

class PointsRouteArgs {
  const PointsRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i37.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i53.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i53.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i37.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i38.ProfileRouter]
class ProfileRouter extends _i53.PageRouteInfo<void> {
  const ProfileRouter({List<_i53.PageRouteInfo>? children})
    : super(ProfileRouter.name, initialChildren: children);

  static const String name = 'ProfileRouter';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i38.ProfileRouter();
    },
  );
}

/// generated route for
/// [_i39.ProfileView]
class ProfileRoute extends _i53.PageRouteInfo<void> {
  const ProfileRoute({List<_i53.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i39.ProfileView();
    },
  );
}

/// generated route for
/// [_i40.RatingsView]
class RatingsRoute extends _i53.PageRouteInfo<void> {
  const RatingsRoute({List<_i53.PageRouteInfo>? children})
    : super(RatingsRoute.name, initialChildren: children);

  static const String name = 'RatingsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i40.RatingsView();
    },
  );
}

/// generated route for
/// [_i41.ResetPasswordView]
class ResetPasswordRoute extends _i53.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i54.Key? key,
    required _i76.AuthCubit authCubit,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i41.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i54.Key? key;

  final _i76.AuthCubit authCubit;

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
/// [_i42.SelectPlanView]
class SelectPlanRoute extends _i53.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i53.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i42.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i43.SettingsView]
class SettingsRoute extends _i53.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>();
      return _i43.SettingsView(key: args.key, role: args.role);
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, required this.role});

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

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
/// [_i44.SignInView]
class SignInRoute extends _i53.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i54.Key? key,
    _i54.VoidCallback? onSignedIn,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i44.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i54.Key? key;

  final _i54.VoidCallback? onSignedIn;

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
/// [_i45.SplashView]
class SplashRoute extends _i53.PageRouteInfo<void> {
  const SplashRoute({List<_i53.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i45.SplashView();
    },
  );
}

/// generated route for
/// [_i46.StatisticsView]
class StatisticsRoute extends _i53.PageRouteInfo<void> {
  const StatisticsRoute({List<_i53.PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i46.StatisticsView();
    },
  );
}

/// generated route for
/// [_i47.SubscriberEvaluationView]
class SubscriberEvaluationRoute
    extends _i53.PageRouteInfo<SubscriberEvaluationRouteArgs> {
  SubscriberEvaluationRoute({
    _i54.Key? key,
    required _i74.UserRoleEnum role,
    required _i72.CustomerModel customer,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubscriberEvaluationRouteArgs>();
      return _i47.SubscriberEvaluationView(
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

  final _i54.Key? key;

  final _i74.UserRoleEnum role;

  final _i72.CustomerModel customer;

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
/// [_i48.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i53.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i53.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i48.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i49.UpdateCustomerInfoView]
class UpdateCustomerInfoRoute
    extends _i53.PageRouteInfo<UpdateCustomerInfoRouteArgs> {
  UpdateCustomerInfoRoute({
    _i54.Key? key,
    required _i73.CustomersCubit customersCubit,
    required _i72.CustomerModel customer,
    required _i74.UserRoleEnum role,
    List<_i53.PageRouteInfo>? children,
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

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateCustomerInfoRouteArgs>();
      return _i49.UpdateCustomerInfoView(
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

  final _i54.Key? key;

  final _i73.CustomersCubit customersCubit;

  final _i72.CustomerModel customer;

  final _i74.UserRoleEnum role;

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
/// [_i50.UserNavigationView]
class UserNavigationRoute extends _i53.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i53.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i50.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i51.UsersView]
class UsersRoute extends _i53.PageRouteInfo<void> {
  const UsersRoute({List<_i53.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i51.UsersView();
    },
  );
}

/// generated route for
/// [_i52.VerifyResetCodeView]
class VerifyResetCodeRoute
    extends _i53.PageRouteInfo<VerifyResetCodeRouteArgs> {
  VerifyResetCodeRoute({
    _i54.Key? key,
    required _i76.AuthCubit authCubit,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         VerifyResetCodeRoute.name,
         args: VerifyResetCodeRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'VerifyResetCodeRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyResetCodeRouteArgs>();
      return _i52.VerifyResetCodeView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class VerifyResetCodeRouteArgs {
  const VerifyResetCodeRouteArgs({this.key, required this.authCubit});

  final _i54.Key? key;

  final _i76.AuthCubit authCubit;

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
