// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i35;
import 'package:flutter/material.dart' as _i36;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i37;
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart'
    as _i38;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i48;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i44;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i9;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i17;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i30;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i10;
import 'package:wellnesstrackerapp/features/company_info/view/company_info_view.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i46;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i45;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i7;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_router.dart'
    as _i14;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i18;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i19;
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart'
    as _i39;
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart'
    as _i40;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i20;
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart'
    as _i42;
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart'
    as _i41;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/levels/view/widgets/add_level_widget.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i22;
import 'package:wellnesstrackerapp/features/notifications/view/notifications_view.dart'
    as _i23;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i24;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i26;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i28;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i29;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i31;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i32;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i33;
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart'
    as _i47;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i34;
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart' as _i43;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i35.PageRouteInfo<void> {
  const AboutUsRoute({List<_i35.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddAdvView]
class AddAdvRoute extends _i35.PageRouteInfo<AddAdvRouteArgs> {
  AddAdvRoute({
    _i36.Key? key,
    required _i37.AddsAndOffersCubit advCubit,
    _i38.AdvModel? adv,
    _i36.VoidCallback? onSuccess,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.AddsAndOffersCubit advCubit;

  final _i38.AdvModel? adv;

  final _i36.VoidCallback? onSuccess;

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
/// [_i3.AddItemView]
class AddItemRoute extends _i35.PageRouteInfo<AddItemRouteArgs> {
  AddItemRoute({
    _i36.Key? key,
    required _i39.ItemsCubit itemCubit,
    _i40.ItemModel? item,
    _i36.VoidCallback? onSuccess,
    _i41.LevelModel? level,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddItemRouteArgs>();
      return _i3.AddItemView(
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

  final _i36.Key? key;

  final _i39.ItemsCubit itemCubit;

  final _i40.ItemModel? item;

  final _i36.VoidCallback? onSuccess;

  final _i41.LevelModel? level;

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
/// [_i4.AddLevelView]
class AddLevelRoute extends _i35.PageRouteInfo<AddLevelRouteArgs> {
  AddLevelRoute({
    _i36.Key? key,
    required _i42.LevelsCubit levelsCubit,
    _i36.VoidCallback? onSuccess,
    _i41.LevelModel? level,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddLevelRouteArgs>();
      return _i4.AddLevelView(
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

  final _i36.Key? key;

  final _i42.LevelsCubit levelsCubit;

  final _i36.VoidCallback? onSuccess;

  final _i41.LevelModel? level;

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
/// [_i5.AddsAndOffersView]
class AddsAndOffersRoute extends _i35.PageRouteInfo<AddsAndOffersRouteArgs> {
  AddsAndOffersRoute({
    _i36.Key? key,
    required _i43.UserRoleEnum role,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         AddsAndOffersRoute.name,
         args: AddsAndOffersRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'AddsAndOffersRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddsAndOffersRouteArgs>();
      return _i5.AddsAndOffersView(key: args.key, role: args.role);
    },
  );
}

class AddsAndOffersRouteArgs {
  const AddsAndOffersRouteArgs({this.key, required this.role});

  final _i36.Key? key;

  final _i43.UserRoleEnum role;

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
/// [_i6.AppManagerView]
class AppManagerRoute extends _i35.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i36.Key? key,
    required _i44.SignInModel user,
    required bool isCustomer,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         AppManagerRoute.name,
         args: AppManagerRouteArgs(
           key: key,
           user: user,
           isCustomer: isCustomer,
         ),
         initialChildren: children,
       );

  static const String name = 'AppManagerRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i6.AppManagerView(
        key: args.key,
        user: args.user,
        isCustomer: args.isCustomer,
      );
    },
  );
}

class AppManagerRouteArgs {
  const AppManagerRouteArgs({
    this.key,
    required this.user,
    required this.isCustomer,
  });

  final _i36.Key? key;

  final _i44.SignInModel user;

  final bool isCustomer;

  @override
  String toString() {
    return 'AppManagerRouteArgs{key: $key, user: $user, isCustomer: $isCustomer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppManagerRouteArgs) return false;
    return key == other.key &&
        user == other.user &&
        isCustomer == other.isCustomer;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode ^ isCustomer.hashCode;
}

/// generated route for
/// [_i7.ApproveCustomerView]
class ApproveCustomerRoute
    extends _i35.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i36.Key? key,
    required _i45.CustomerModel customer,
    required _i46.CustomersCubit customersCubit,
    _i36.VoidCallback? onSuccess,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApproveCustomerRouteArgs>();
      return _i7.ApproveCustomerView(
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

  final _i36.Key? key;

  final _i45.CustomerModel customer;

  final _i46.CustomersCubit customersCubit;

  final _i36.VoidCallback? onSuccess;

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
/// [_i8.AuthManagerView]
class AuthManagerRoute extends _i35.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i35.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i8.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i9.AuthRouterPage]
class AuthRouter extends _i35.PageRouteInfo<void> {
  const AuthRouter({List<_i35.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i9.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i10.CodesView]
class CodesRoute extends _i35.PageRouteInfo<void> {
  const CodesRoute({List<_i35.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i10.CodesView();
    },
  );
}

/// generated route for
/// [_i11.CompanyInfoView]
class CompanyInfoRoute extends _i35.PageRouteInfo<void> {
  const CompanyInfoRoute({List<_i35.PageRouteInfo>? children})
    : super(CompanyInfoRoute.name, initialChildren: children);

  static const String name = 'CompanyInfoRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i11.CompanyInfoView();
    },
  );
}

/// generated route for
/// [_i12.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i35.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i35.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i12.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i13.CustomersView]
class CustomersRoute extends _i35.PageRouteInfo<CustomersRouteArgs> {
  CustomersRoute({
    _i36.Key? key,
    required _i43.UserRoleEnum role,
    _i47.UserModel? user,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         CustomersRoute.name,
         args: CustomersRouteArgs(key: key, role: role, user: user),
         initialChildren: children,
       );

  static const String name = 'CustomersRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomersRouteArgs>();
      return _i13.CustomersView(
        key: args.key,
        role: args.role,
        user: args.user,
      );
    },
  );
}

class CustomersRouteArgs {
  const CustomersRouteArgs({this.key, required this.role, this.user});

  final _i36.Key? key;

  final _i43.UserRoleEnum role;

  final _i47.UserModel? user;

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
/// [_i14.DashboardRouter]
class DashboardRouter extends _i35.PageRouteInfo<void> {
  const DashboardRouter({List<_i35.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i14.DashboardRouter();
    },
  );
}

/// generated route for
/// [_i15.DashboardView]
class DashboardRoute extends _i35.PageRouteInfo<void> {
  const DashboardRoute({List<_i35.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i15.DashboardView();
    },
  );
}

/// generated route for
/// [_i16.ExercisesView]
class ExercisesRoute extends _i35.PageRouteInfo<void> {
  const ExercisesRoute({List<_i35.PageRouteInfo>? children})
    : super(ExercisesRoute.name, initialChildren: children);

  static const String name = 'ExercisesRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i16.ExercisesView();
    },
  );
}

/// generated route for
/// [_i17.ForgotPasswordView]
class ForgotPasswordRoute extends _i35.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i36.Key? key,
    required _i48.AuthCubit authCubit,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i17.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i36.Key? key;

  final _i48.AuthCubit authCubit;

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
/// [_i18.HealthAssesmentView]
class HealthAssesmentRoute extends _i35.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i35.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i18.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i19.IntroView]
class IntroRoute extends _i35.PageRouteInfo<void> {
  const IntroRoute({List<_i35.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i19.IntroView();
    },
  );
}

/// generated route for
/// [_i20.ItemsView]
class ItemsRoute extends _i35.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i36.Key? key,
    required _i43.UserRoleEnum role,
    _i41.LevelModel? level,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, role: role, level: level),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>();
      return _i20.ItemsView(key: args.key, role: args.role, level: args.level);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, required this.role, this.level});

  final _i36.Key? key;

  final _i43.UserRoleEnum role;

  final _i41.LevelModel? level;

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
/// [_i21.LevelsView]
class LevelsRoute extends _i35.PageRouteInfo<LevelsRouteArgs> {
  LevelsRoute({
    _i36.Key? key,
    required _i43.UserRoleEnum role,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         LevelsRoute.name,
         args: LevelsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'LevelsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LevelsRouteArgs>();
      return _i21.LevelsView(key: args.key, role: args.role);
    },
  );
}

class LevelsRouteArgs {
  const LevelsRouteArgs({this.key, required this.role});

  final _i36.Key? key;

  final _i43.UserRoleEnum role;

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
/// [_i22.MealsView]
class MealsRoute extends _i35.PageRouteInfo<void> {
  const MealsRoute({List<_i35.PageRouteInfo>? children})
    : super(MealsRoute.name, initialChildren: children);

  static const String name = 'MealsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i22.MealsView();
    },
  );
}

/// generated route for
/// [_i23.NotificationsView]
class NotificationsRoute extends _i35.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i36.Key? key,
    required _i43.UserRoleEnum role,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         NotificationsRoute.name,
         args: NotificationsRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'NotificationsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i23.NotificationsView(key: args.key, role: args.role);
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({this.key, required this.role});

  final _i36.Key? key;

  final _i43.UserRoleEnum role;

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
/// [_i24.PointsView]
class PointsRoute extends _i35.PageRouteInfo<void> {
  const PointsRoute({List<_i35.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i24.PointsView();
    },
  );
}

/// generated route for
/// [_i25.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i35.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i35.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i25.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i26.ProfileView]
class ProfileRoute extends _i35.PageRouteInfo<void> {
  const ProfileRoute({List<_i35.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i26.ProfileView();
    },
  );
}

/// generated route for
/// [_i27.ResetPasswordView]
class ResetPasswordRoute extends _i35.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i36.Key? key,
    required _i48.AuthCubit authCubit,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i27.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i36.Key? key;

  final _i48.AuthCubit authCubit;

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
/// [_i28.SelectPlanView]
class SelectPlanRoute extends _i35.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i35.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i28.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i29.SettingsView]
class SettingsRoute extends _i35.PageRouteInfo<void> {
  const SettingsRoute({List<_i35.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i29.SettingsView();
    },
  );
}

/// generated route for
/// [_i30.SignInView]
class SignInRoute extends _i35.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i36.Key? key,
    _i36.VoidCallback? onSignedIn,
    List<_i35.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i30.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i36.Key? key;

  final _i36.VoidCallback? onSignedIn;

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
/// [_i31.SplashView]
class SplashRoute extends _i35.PageRouteInfo<void> {
  const SplashRoute({List<_i35.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i31.SplashView();
    },
  );
}

/// generated route for
/// [_i32.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i35.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i35.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i32.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i33.UserNavigationView]
class UserNavigationRoute extends _i35.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i35.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i33.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i34.UsersView]
class UsersRoute extends _i35.PageRouteInfo<void> {
  const UsersRoute({List<_i35.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i34.UsersView();
    },
  );
}
