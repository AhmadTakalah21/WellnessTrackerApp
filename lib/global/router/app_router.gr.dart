// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i34;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i31;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i6;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i24;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i7;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i33;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i32;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i10;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i14;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i15;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i17;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i18;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i19;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i20;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i22;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i23;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i26;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i28;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i29.PageRouteInfo<void> {
  const AboutUsRoute({List<_i29.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddsAndOffersView]
class AddsAndOffersRoute extends _i29.PageRouteInfo<void> {
  const AddsAndOffersRoute({List<_i29.PageRouteInfo>? children})
    : super(AddsAndOffersRoute.name, initialChildren: children);

  static const String name = 'AddsAndOffersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddsAndOffersView();
    },
  );
}

/// generated route for
/// [_i3.AppManagerView]
class AppManagerRoute extends _i29.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i30.Key? key,
    required _i31.SignInModel user,
    required bool isCustomer,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i3.AppManagerView(
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

  final _i30.Key? key;

  final _i31.SignInModel user;

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
/// [_i4.ApproveCustomerView]
class ApproveCustomerRoute
    extends _i29.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i30.Key? key,
    required _i32.CustomerModel customer,
    required _i33.CustomersCubit customersCubit,
    _i30.VoidCallback? onSuccess,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApproveCustomerRouteArgs>();
      return _i4.ApproveCustomerView(
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

  final _i30.Key? key;

  final _i32.CustomerModel customer;

  final _i33.CustomersCubit customersCubit;

  final _i30.VoidCallback? onSuccess;

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
/// [_i5.AuthManagerView]
class AuthManagerRoute extends _i29.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i29.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i6.AuthRouterPage]
class AuthRouter extends _i29.PageRouteInfo<void> {
  const AuthRouter({List<_i29.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i6.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i7.CodesView]
class CodesRoute extends _i29.PageRouteInfo<void> {
  const CodesRoute({List<_i29.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i7.CodesView();
    },
  );
}

/// generated route for
/// [_i8.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i29.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i29.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i8.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i9.CustomersView]
class CustomersRoute extends _i29.PageRouteInfo<void> {
  const CustomersRoute({List<_i29.PageRouteInfo>? children})
    : super(CustomersRoute.name, initialChildren: children);

  static const String name = 'CustomersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i9.CustomersView();
    },
  );
}

/// generated route for
/// [_i10.DashboardView]
class DashboardRoute extends _i29.PageRouteInfo<void> {
  const DashboardRoute({List<_i29.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i10.DashboardView();
    },
  );
}

/// generated route for
/// [_i11.ExercisesView]
class ExercisesRoute extends _i29.PageRouteInfo<void> {
  const ExercisesRoute({List<_i29.PageRouteInfo>? children})
    : super(ExercisesRoute.name, initialChildren: children);

  static const String name = 'ExercisesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i11.ExercisesView();
    },
  );
}

/// generated route for
/// [_i12.ForgotPasswordView]
class ForgotPasswordRoute extends _i29.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i30.Key? key,
    required _i34.AuthCubit authCubit,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i12.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i30.Key? key;

  final _i34.AuthCubit authCubit;

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
/// [_i13.HealthAssesmentView]
class HealthAssesmentRoute extends _i29.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i29.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i14.IntroView]
class IntroRoute extends _i29.PageRouteInfo<void> {
  const IntroRoute({List<_i29.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.IntroView();
    },
  );
}

/// generated route for
/// [_i15.ItemsView]
class ItemsRoute extends _i29.PageRouteInfo<void> {
  const ItemsRoute({List<_i29.PageRouteInfo>? children})
    : super(ItemsRoute.name, initialChildren: children);

  static const String name = 'ItemsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i15.ItemsView();
    },
  );
}

/// generated route for
/// [_i16.LevelsView]
class LevelsRoute extends _i29.PageRouteInfo<void> {
  const LevelsRoute({List<_i29.PageRouteInfo>? children})
    : super(LevelsRoute.name, initialChildren: children);

  static const String name = 'LevelsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.LevelsView();
    },
  );
}

/// generated route for
/// [_i17.MealsView]
class MealsRoute extends _i29.PageRouteInfo<void> {
  const MealsRoute({List<_i29.PageRouteInfo>? children})
    : super(MealsRoute.name, initialChildren: children);

  static const String name = 'MealsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.MealsView();
    },
  );
}

/// generated route for
/// [_i18.PointsView]
class PointsRoute extends _i29.PageRouteInfo<void> {
  const PointsRoute({List<_i29.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i18.PointsView();
    },
  );
}

/// generated route for
/// [_i19.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i29.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i29.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i19.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i20.ProfileView]
class ProfileRoute extends _i29.PageRouteInfo<void> {
  const ProfileRoute({List<_i29.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.ProfileView();
    },
  );
}

/// generated route for
/// [_i21.ResetPasswordView]
class ResetPasswordRoute extends _i29.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i30.Key? key,
    required _i34.AuthCubit authCubit,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i21.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i30.Key? key;

  final _i34.AuthCubit authCubit;

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
/// [_i22.SelectPlanView]
class SelectPlanRoute extends _i29.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i29.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i22.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i23.SettingsView]
class SettingsRoute extends _i29.PageRouteInfo<void> {
  const SettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i23.SettingsView();
    },
  );
}

/// generated route for
/// [_i24.SignInView]
class SignInRoute extends _i29.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i30.Key? key,
    _i30.VoidCallback? onSignedIn,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i24.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i30.Key? key;

  final _i30.VoidCallback? onSignedIn;

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
/// [_i25.SplashView]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i25.SplashView();
    },
  );
}

/// generated route for
/// [_i26.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i29.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i29.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i26.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i27.UserNavigationView]
class UserNavigationRoute extends _i29.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i29.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i27.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i28.UsersView]
class UsersRoute extends _i29.PageRouteInfo<void> {
  const UsersRoute({List<_i29.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i28.UsersView();
    },
  );
}
