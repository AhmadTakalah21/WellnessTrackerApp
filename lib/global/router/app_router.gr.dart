// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i39;
import 'package:flutter/material.dart' as _i40;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i41;
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart'
    as _i42;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i10;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i60;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i56;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i13;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i31;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i34;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i14;
import 'package:wellnesstrackerapp/features/company_info/view/company_info_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i58;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i57;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i17;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_router.dart'
    as _i18;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i19;
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart'
    as _i43;
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart'
    as _i44;
import 'package:wellnesstrackerapp/features/exercise_plans/view/add_exercise_plan_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart'
    as _i45;
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart'
    as _i46;
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i20;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i22;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i23;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i47;
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart'
    as _i48;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i24;
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart'
    as _i50;
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart'
    as _i49;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/levels/view/widgets/add_level_widget.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart'
    as _i51;
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart'
    as _i52;
import 'package:wellnesstrackerapp/features/meal_plans/view/add_meal_plans.dart'
    as _i7;
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart'
    as _i53;
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart'
    as _i54;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i26;
import 'package:wellnesstrackerapp/features/notifications/view/notifications_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i28;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i29;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i30;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i32;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i33;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i35;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i36;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i37;
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart'
    as _i59;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i38;
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart' as _i55;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i39.PageRouteInfo<void> {
  const AboutUsRoute({List<_i39.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddAdvView]
class AddAdvRoute extends _i39.PageRouteInfo<AddAdvRouteArgs> {
  AddAdvRoute({
    _i40.Key? key,
    required _i41.AddsAndOffersCubit advCubit,
    _i42.AdvModel? adv,
    _i40.VoidCallback? onSuccess,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i41.AddsAndOffersCubit advCubit;

  final _i42.AdvModel? adv;

  final _i40.VoidCallback? onSuccess;

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
    extends _i39.PageRouteInfo<AddExercisePlanRouteArgs> {
  AddExercisePlanRoute({
    _i40.Key? key,
    required _i43.ExercisePlansCubit exercisePlansCubit,
    _i44.ExercisePlanModel? exercisePlan,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i43.ExercisePlansCubit exercisePlansCubit;

  final _i44.ExercisePlanModel? exercisePlan;

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
class AddExerciseRoute extends _i39.PageRouteInfo<AddExerciseRouteArgs> {
  AddExerciseRoute({
    _i40.Key? key,
    required _i45.ExercisesCubit exercisesCubit,
    _i46.ExerciseModel? exercise,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i45.ExercisesCubit exercisesCubit;

  final _i46.ExerciseModel? exercise;

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
class AddItemRoute extends _i39.PageRouteInfo<AddItemRouteArgs> {
  AddItemRoute({
    _i40.Key? key,
    required _i47.ItemsCubit itemCubit,
    _i48.ItemModel? item,
    _i40.VoidCallback? onSuccess,
    _i49.LevelModel? level,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i47.ItemsCubit itemCubit;

  final _i48.ItemModel? item;

  final _i40.VoidCallback? onSuccess;

  final _i49.LevelModel? level;

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
class AddLevelRoute extends _i39.PageRouteInfo<AddLevelRouteArgs> {
  AddLevelRoute({
    _i40.Key? key,
    required _i50.LevelsCubit levelsCubit,
    _i40.VoidCallback? onSuccess,
    _i49.LevelModel? level,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i50.LevelsCubit levelsCubit;

  final _i40.VoidCallback? onSuccess;

  final _i49.LevelModel? level;

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
class AddMealPlanRoute extends _i39.PageRouteInfo<AddMealPlanRouteArgs> {
  AddMealPlanRoute({
    _i40.Key? key,
    required _i51.MealPlansCubit mealPlansCubit,
    _i52.MealPlanModel? mealPlan,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i51.MealPlansCubit mealPlansCubit;

  final _i52.MealPlanModel? mealPlan;

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
class AddMealRoute extends _i39.PageRouteInfo<AddMealRouteArgs> {
  AddMealRoute({
    _i40.Key? key,
    required _i53.MealsCubit mealsCubit,
    _i54.MealModel? meal,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         AddMealRoute.name,
         args: AddMealRouteArgs(key: key, mealsCubit: mealsCubit, meal: meal),
         initialChildren: children,
       );

  static const String name = 'AddMealRoute';

  static _i39.PageInfo page = _i39.PageInfo(
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

  final _i40.Key? key;

  final _i53.MealsCubit mealsCubit;

  final _i54.MealModel? meal;

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
/// [_i9.AddsAndOffersView]
class AddsAndOffersRoute extends _i39.PageRouteInfo<AddsAndOffersRouteArgs> {
  AddsAndOffersRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         AddsAndOffersRoute.name,
         args: AddsAndOffersRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'AddsAndOffersRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddsAndOffersRouteArgs>();
      return _i9.AddsAndOffersView(key: args.key, role: args.role);
    },
  );
}

class AddsAndOffersRouteArgs {
  const AddsAndOffersRouteArgs({this.key, required this.role});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

  @override
  String toString() {
    return 'AddsAndOffersRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddsAndOffersRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [_i10.AppManagerView]
class AppManagerRoute extends _i39.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i40.Key? key,
    required _i56.SignInModel user,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         AppManagerRoute.name,
         args: AppManagerRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'AppManagerRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i10.AppManagerView(key: args.key, user: args.user);
    },
  );
}

class AppManagerRouteArgs {
  const AppManagerRouteArgs({this.key, required this.user});

  final _i40.Key? key;

  final _i56.SignInModel user;

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
/// [_i11.ApproveCustomerView]
class ApproveCustomerRoute
    extends _i39.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i40.Key? key,
    required _i57.CustomerModel customer,
    required _i58.CustomersCubit customersCubit,
    _i40.VoidCallback? onSuccess,
    List<_i39.PageRouteInfo>? children,
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

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApproveCustomerRouteArgs>();
      return _i11.ApproveCustomerView(
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

  final _i40.Key? key;

  final _i57.CustomerModel customer;

  final _i58.CustomersCubit customersCubit;

  final _i40.VoidCallback? onSuccess;

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
/// [_i12.AuthManagerView]
class AuthManagerRoute extends _i39.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i39.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i12.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i13.AuthRouterPage]
class AuthRouter extends _i39.PageRouteInfo<void> {
  const AuthRouter({List<_i39.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i13.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i14.CodesView]
class CodesRoute extends _i39.PageRouteInfo<void> {
  const CodesRoute({List<_i39.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i14.CodesView();
    },
  );
}

/// generated route for
/// [_i15.CompanyInfoView]
class CompanyInfoRoute extends _i39.PageRouteInfo<void> {
  const CompanyInfoRoute({List<_i39.PageRouteInfo>? children})
    : super(CompanyInfoRoute.name, initialChildren: children);

  static const String name = 'CompanyInfoRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i15.CompanyInfoView();
    },
  );
}

/// generated route for
/// [_i16.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i39.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i39.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i16.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i17.CustomersView]
class CustomersRoute extends _i39.PageRouteInfo<CustomersRouteArgs> {
  CustomersRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    _i59.UserModel? user,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         CustomersRoute.name,
         args: CustomersRouteArgs(key: key, role: role, user: user),
         initialChildren: children,
       );

  static const String name = 'CustomersRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomersRouteArgs>();
      return _i17.CustomersView(
        key: args.key,
        role: args.role,
        user: args.user,
      );
    },
  );
}

class CustomersRouteArgs {
  const CustomersRouteArgs({this.key, required this.role, this.user});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

  final _i59.UserModel? user;

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
/// [_i18.DashboardRouter]
class DashboardRouter extends _i39.PageRouteInfo<void> {
  const DashboardRouter({List<_i39.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i18.DashboardRouter();
    },
  );
}

/// generated route for
/// [_i19.DashboardView]
class DashboardRoute extends _i39.PageRouteInfo<void> {
  const DashboardRoute({List<_i39.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i19.DashboardView();
    },
  );
}

/// generated route for
/// [_i20.ExercisesView]
class ExercisesRoute extends _i39.PageRouteInfo<ExercisesRouteArgs> {
  ExercisesRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ExercisesRoute.name,
         args: ExercisesRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'ExercisesRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisesRouteArgs>();
      return _i20.ExercisesView(key: args.key, role: args.role);
    },
  );
}

class ExercisesRouteArgs {
  const ExercisesRouteArgs({this.key, required this.role});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

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
/// [_i21.ForgotPasswordView]
class ForgotPasswordRoute extends _i39.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i40.Key? key,
    required _i60.AuthCubit authCubit,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i21.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i40.Key? key;

  final _i60.AuthCubit authCubit;

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
/// [_i22.HealthAssesmentView]
class HealthAssesmentRoute extends _i39.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i39.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i22.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i23.IntroView]
class IntroRoute extends _i39.PageRouteInfo<void> {
  const IntroRoute({List<_i39.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i23.IntroView();
    },
  );
}

/// generated route for
/// [_i24.ItemsView]
class ItemsRoute extends _i39.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    _i49.LevelModel? level,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, role: role, level: level),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>();
      return _i24.ItemsView(key: args.key, role: args.role, level: args.level);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, required this.role, this.level});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

  final _i49.LevelModel? level;

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
/// [_i25.LevelsView]
class LevelsRoute extends _i39.PageRouteInfo<LevelsRouteArgs> {
  LevelsRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         LevelsRoute.name,
         args: LevelsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'LevelsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LevelsRouteArgs>();
      return _i25.LevelsView(key: args.key, role: args.role);
    },
  );
}

class LevelsRouteArgs {
  const LevelsRouteArgs({this.key, required this.role});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

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
/// [_i26.MealsView]
class MealsRoute extends _i39.PageRouteInfo<MealsRouteArgs> {
  MealsRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         MealsRoute.name,
         args: MealsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'MealsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealsRouteArgs>();
      return _i26.MealsView(key: args.key, role: args.role);
    },
  );
}

class MealsRouteArgs {
  const MealsRouteArgs({this.key, required this.role});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

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
/// [_i27.NotificationsView]
class NotificationsRoute extends _i39.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i40.Key? key,
    required _i55.UserRoleEnum role,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         NotificationsRoute.name,
         args: NotificationsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'NotificationsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i27.NotificationsView(key: args.key, role: args.role);
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({this.key, required this.role});

  final _i40.Key? key;

  final _i55.UserRoleEnum role;

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
/// [_i28.PointsView]
class PointsRoute extends _i39.PageRouteInfo<void> {
  const PointsRoute({List<_i39.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i28.PointsView();
    },
  );
}

/// generated route for
/// [_i29.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i39.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i39.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i29.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i30.ProfileView]
class ProfileRoute extends _i39.PageRouteInfo<void> {
  const ProfileRoute({List<_i39.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i30.ProfileView();
    },
  );
}

/// generated route for
/// [_i31.ResetPasswordView]
class ResetPasswordRoute extends _i39.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i40.Key? key,
    required _i60.AuthCubit authCubit,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i31.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i40.Key? key;

  final _i60.AuthCubit authCubit;

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
/// [_i32.SelectPlanView]
class SelectPlanRoute extends _i39.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i39.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i32.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i33.SettingsView]
class SettingsRoute extends _i39.PageRouteInfo<void> {
  const SettingsRoute({List<_i39.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i33.SettingsView();
    },
  );
}

/// generated route for
/// [_i34.SignInView]
class SignInRoute extends _i39.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i40.Key? key,
    _i40.VoidCallback? onSignedIn,
    List<_i39.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i34.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i40.Key? key;

  final _i40.VoidCallback? onSignedIn;

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
/// [_i35.SplashView]
class SplashRoute extends _i39.PageRouteInfo<void> {
  const SplashRoute({List<_i39.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i35.SplashView();
    },
  );
}

/// generated route for
/// [_i36.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i39.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i39.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i36.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i37.UserNavigationView]
class UserNavigationRoute extends _i39.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i39.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i37.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i38.UsersView]
class UsersRoute extends _i39.PageRouteInfo<void> {
  const UsersRoute({List<_i39.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i39.PageInfo page = _i39.PageInfo(
    name,
    builder: (data) {
      return const _i38.UsersView();
    },
  );
}
