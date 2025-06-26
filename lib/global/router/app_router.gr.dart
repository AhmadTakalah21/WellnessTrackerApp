// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i22;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i3;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i8;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i14;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i4;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i7;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i10;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i11;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i12;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i17;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i18;

/// generated route for
/// [_i1.AppManagerView]
class AppManagerRoute extends _i19.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i20.Key? key,
    required _i21.SignInModel user,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         AppManagerRoute.name,
         args: AppManagerRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'AppManagerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i1.AppManagerView(key: args.key, user: args.user);
    },
  );
}

class AppManagerRouteArgs {
  const AppManagerRouteArgs({this.key, required this.user});

  final _i20.Key? key;

  final _i21.SignInModel user;

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
/// [_i2.AuthManagerView]
class AuthManagerRoute extends _i19.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i19.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i3.AuthRouterPage]
class AuthRouter extends _i19.PageRouteInfo<void> {
  const AuthRouter({List<_i19.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i4.CodesView]
class CodesRoute extends _i19.PageRouteInfo<void> {
  const CodesRoute({List<_i19.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.CodesView();
    },
  );
}

/// generated route for
/// [_i5.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i19.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i19.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i6.DashboardView]
class DashboardRoute extends _i19.PageRouteInfo<void> {
  const DashboardRoute({List<_i19.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.DashboardView();
    },
  );
}

/// generated route for
/// [_i7.ExercisesView]
class ExercisesRoute extends _i19.PageRouteInfo<void> {
  const ExercisesRoute({List<_i19.PageRouteInfo>? children})
    : super(ExercisesRoute.name, initialChildren: children);

  static const String name = 'ExercisesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.ExercisesView();
    },
  );
}

/// generated route for
/// [_i8.ForgotPasswordView]
class ForgotPasswordRoute extends _i19.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i20.Key? key,
    required _i22.AuthCubit authCubit,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i8.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i20.Key? key;

  final _i22.AuthCubit authCubit;

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
/// [_i9.HealthAssesmentView]
class HealthAssesmentRoute extends _i19.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i19.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i9.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i10.IntroView]
class IntroRoute extends _i19.PageRouteInfo<void> {
  const IntroRoute({List<_i19.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.IntroView();
    },
  );
}

/// generated route for
/// [_i11.ItemsView]
class ItemsRoute extends _i19.PageRouteInfo<void> {
  const ItemsRoute({List<_i19.PageRouteInfo>? children})
    : super(ItemsRoute.name, initialChildren: children);

  static const String name = 'ItemsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i11.ItemsView();
    },
  );
}

/// generated route for
/// [_i12.MealsView]
class MealsRoute extends _i19.PageRouteInfo<void> {
  const MealsRoute({List<_i19.PageRouteInfo>? children})
    : super(MealsRoute.name, initialChildren: children);

  static const String name = 'MealsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i12.MealsView();
    },
  );
}

/// generated route for
/// [_i13.PointsView]
class PointsRoute extends _i19.PageRouteInfo<void> {
  const PointsRoute({List<_i19.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i13.PointsView();
    },
  );
}

/// generated route for
/// [_i14.ResetPasswordView]
class ResetPasswordRoute extends _i19.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i20.Key? key,
    required _i22.AuthCubit authCubit,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i14.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i20.Key? key;

  final _i22.AuthCubit authCubit;

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
/// [_i15.SelectPlanView]
class SelectPlanRoute extends _i19.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i19.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i16.SignInView]
class SignInRoute extends _i19.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i20.Key? key,
    _i20.VoidCallback? onSignedIn,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i16.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i20.Key? key;

  final _i20.VoidCallback? onSignedIn;

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
/// [_i17.SplashView]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i17.SplashView();
    },
  );
}

/// generated route for
/// [_i18.UsersView]
class UsersRoute extends _i19.PageRouteInfo<void> {
  const UsersRoute({List<_i19.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.UsersView();
    },
  );
}
