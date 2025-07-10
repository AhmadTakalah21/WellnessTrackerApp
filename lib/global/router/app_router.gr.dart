// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/material.dart' as _i34;
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart'
    as _i1;
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart'
    as _i35;
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart'
    as _i36;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/adds_and_offers_view.dart'
    as _i3;
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart'
    as _i2;
import 'package:wellnesstrackerapp/features/app_manager/view/app_manager_view.dart'
    as _i4;
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart' as _i41;
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart'
    as _i38;
import 'package:wellnesstrackerapp/features/auth/view/auth_router.dart' as _i7;
import 'package:wellnesstrackerapp/features/auth/view/forget_password_view.dart'
    as _i15;
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart'
    as _i10;
import 'package:wellnesstrackerapp/features/auth/view/reset_password_view.dart'
    as _i25;
import 'package:wellnesstrackerapp/features/auth/view/sign_in_view.dart'
    as _i28;
import 'package:wellnesstrackerapp/features/auth_manager/view/auth_manager_view.dart'
    as _i6;
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart' as _i8;
import 'package:wellnesstrackerapp/features/company_info/view/company_info_view.dart'
    as _i9;
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart'
    as _i40;
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart'
    as _i39;
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart'
    as _i11;
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart'
    as _i5;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_router.dart'
    as _i12;
import 'package:wellnesstrackerapp/features/dashboard/view/dashboard_view.dart'
    as _i13;
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart'
    as _i14;
import 'package:wellnesstrackerapp/features/health_assesment/view/health_assesment_view.dart'
    as _i16;
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart' as _i17;
import 'package:wellnesstrackerapp/features/items/view/items_view.dart' as _i18;
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart'
    as _i19;
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart' as _i20;
import 'package:wellnesstrackerapp/features/notifications/view/notifications_view.dart'
    as _i21;
import 'package:wellnesstrackerapp/features/points/view/points_view.dart'
    as _i22;
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart'
    as _i23;
import 'package:wellnesstrackerapp/features/profile/view/profile_view.dart'
    as _i24;
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart'
    as _i26;
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart'
    as _i27;
import 'package:wellnesstrackerapp/features/splash/view/splash_view.dart'
    as _i29;
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart'
    as _i30;
import 'package:wellnesstrackerapp/features/user_navigation/view/user_navigation_view.dart'
    as _i31;
import 'package:wellnesstrackerapp/features/users/view/users_view.dart' as _i32;
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart' as _i37;

/// generated route for
/// [_i1.AboutUsView]
class AboutUsRoute extends _i33.PageRouteInfo<void> {
  const AboutUsRoute({List<_i33.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsView();
    },
  );
}

/// generated route for
/// [_i2.AddAdvView]
class AddAdvRoute extends _i33.PageRouteInfo<AddAdvRouteArgs> {
  AddAdvRoute({
    _i34.Key? key,
    required _i35.AddsAndOffersCubit advCubit,
    required bool isEdit,
    _i36.AdvModel? adv,
    _i34.VoidCallback? onSuccess,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         AddAdvRoute.name,
         args: AddAdvRouteArgs(
           key: key,
           advCubit: advCubit,
           isEdit: isEdit,
           adv: adv,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'AddAdvRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddAdvRouteArgs>();
      return _i2.AddAdvView(
        key: args.key,
        advCubit: args.advCubit,
        isEdit: args.isEdit,
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
    required this.isEdit,
    this.adv,
    this.onSuccess,
  });

  final _i34.Key? key;

  final _i35.AddsAndOffersCubit advCubit;

  final bool isEdit;

  final _i36.AdvModel? adv;

  final _i34.VoidCallback? onSuccess;

  @override
  String toString() {
    return 'AddAdvRouteArgs{key: $key, advCubit: $advCubit, isEdit: $isEdit, adv: $adv, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddAdvRouteArgs) return false;
    return key == other.key &&
        advCubit == other.advCubit &&
        isEdit == other.isEdit &&
        adv == other.adv &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      advCubit.hashCode ^
      isEdit.hashCode ^
      adv.hashCode ^
      onSuccess.hashCode;
}

/// generated route for
/// [_i3.AddsAndOffersView]
class AddsAndOffersRoute extends _i33.PageRouteInfo<AddsAndOffersRouteArgs> {
  AddsAndOffersRoute({
    _i34.Key? key,
    required _i37.UserRoleEnum role,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         AddsAndOffersRoute.name,
         args: AddsAndOffersRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'AddsAndOffersRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddsAndOffersRouteArgs>();
      return _i3.AddsAndOffersView(key: args.key, role: args.role);
    },
  );
}

class AddsAndOffersRouteArgs {
  const AddsAndOffersRouteArgs({this.key, required this.role});

  final _i34.Key? key;

  final _i37.UserRoleEnum role;

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
/// [_i4.AppManagerView]
class AppManagerRoute extends _i33.PageRouteInfo<AppManagerRouteArgs> {
  AppManagerRoute({
    _i34.Key? key,
    required _i38.SignInModel user,
    required bool isCustomer,
    List<_i33.PageRouteInfo>? children,
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

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppManagerRouteArgs>();
      return _i4.AppManagerView(
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

  final _i34.Key? key;

  final _i38.SignInModel user;

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
/// [_i5.ApproveCustomerView]
class ApproveCustomerRoute
    extends _i33.PageRouteInfo<ApproveCustomerRouteArgs> {
  ApproveCustomerRoute({
    _i34.Key? key,
    required _i39.CustomerModel customer,
    required _i40.CustomersCubit customersCubit,
    _i34.VoidCallback? onSuccess,
    List<_i33.PageRouteInfo>? children,
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

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApproveCustomerRouteArgs>();
      return _i5.ApproveCustomerView(
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

  final _i34.Key? key;

  final _i39.CustomerModel customer;

  final _i40.CustomersCubit customersCubit;

  final _i34.VoidCallback? onSuccess;

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
/// [_i6.AuthManagerView]
class AuthManagerRoute extends _i33.PageRouteInfo<void> {
  const AuthManagerRoute({List<_i33.PageRouteInfo>? children})
    : super(AuthManagerRoute.name, initialChildren: children);

  static const String name = 'AuthManagerRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i6.AuthManagerView();
    },
  );
}

/// generated route for
/// [_i7.AuthRouterPage]
class AuthRouter extends _i33.PageRouteInfo<void> {
  const AuthRouter({List<_i33.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i7.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i8.CodesView]
class CodesRoute extends _i33.PageRouteInfo<void> {
  const CodesRoute({List<_i33.PageRouteInfo>? children})
    : super(CodesRoute.name, initialChildren: children);

  static const String name = 'CodesRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i8.CodesView();
    },
  );
}

/// generated route for
/// [_i9.CompanyInfoView]
class CompanyInfoRoute extends _i33.PageRouteInfo<void> {
  const CompanyInfoRoute({List<_i33.PageRouteInfo>? children})
    : super(CompanyInfoRoute.name, initialChildren: children);

  static const String name = 'CompanyInfoRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i9.CompanyInfoView();
    },
  );
}

/// generated route for
/// [_i10.CompleteProfileFormView]
class CompleteProfileFormRoute extends _i33.PageRouteInfo<void> {
  const CompleteProfileFormRoute({List<_i33.PageRouteInfo>? children})
    : super(CompleteProfileFormRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileFormRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i10.CompleteProfileFormView();
    },
  );
}

/// generated route for
/// [_i11.CustomersView]
class CustomersRoute extends _i33.PageRouteInfo<void> {
  const CustomersRoute({List<_i33.PageRouteInfo>? children})
    : super(CustomersRoute.name, initialChildren: children);

  static const String name = 'CustomersRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i11.CustomersView();
    },
  );
}

/// generated route for
/// [_i12.DashboardRouterPage]
class DashboardRouter extends _i33.PageRouteInfo<void> {
  const DashboardRouter({List<_i33.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i12.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i13.DashboardView]
class DashboardRoute extends _i33.PageRouteInfo<void> {
  const DashboardRoute({List<_i33.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i13.DashboardView();
    },
  );
}

/// generated route for
/// [_i14.ExercisesView]
class ExercisesRoute extends _i33.PageRouteInfo<void> {
  const ExercisesRoute({List<_i33.PageRouteInfo>? children})
    : super(ExercisesRoute.name, initialChildren: children);

  static const String name = 'ExercisesRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i14.ExercisesView();
    },
  );
}

/// generated route for
/// [_i15.ForgotPasswordView]
class ForgotPasswordRoute extends _i33.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i34.Key? key,
    required _i41.AuthCubit authCubit,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i15.ForgotPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.authCubit});

  final _i34.Key? key;

  final _i41.AuthCubit authCubit;

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
/// [_i16.HealthAssesmentView]
class HealthAssesmentRoute extends _i33.PageRouteInfo<void> {
  const HealthAssesmentRoute({List<_i33.PageRouteInfo>? children})
    : super(HealthAssesmentRoute.name, initialChildren: children);

  static const String name = 'HealthAssesmentRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i16.HealthAssesmentView();
    },
  );
}

/// generated route for
/// [_i17.IntroView]
class IntroRoute extends _i33.PageRouteInfo<void> {
  const IntroRoute({List<_i33.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i17.IntroView();
    },
  );
}

/// generated route for
/// [_i18.ItemsView]
class ItemsRoute extends _i33.PageRouteInfo<void> {
  const ItemsRoute({List<_i33.PageRouteInfo>? children})
    : super(ItemsRoute.name, initialChildren: children);

  static const String name = 'ItemsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i18.ItemsView();
    },
  );
}

/// generated route for
/// [_i19.LevelsView]
class LevelsRoute extends _i33.PageRouteInfo<void> {
  const LevelsRoute({List<_i33.PageRouteInfo>? children})
    : super(LevelsRoute.name, initialChildren: children);

  static const String name = 'LevelsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i19.LevelsView();
    },
  );
}

/// generated route for
/// [_i20.MealsView]
class MealsRoute extends _i33.PageRouteInfo<void> {
  const MealsRoute({List<_i33.PageRouteInfo>? children})
    : super(MealsRoute.name, initialChildren: children);

  static const String name = 'MealsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i20.MealsView();
    },
  );
}

/// generated route for
/// [_i21.NotificationsView]
class NotificationsRoute extends _i33.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i34.Key? key,
    required bool canSendNotification,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         NotificationsRoute.name,
         args: NotificationsRouteArgs(
           key: key,
           canSendNotification: canSendNotification,
         ),
         initialChildren: children,
       );

  static const String name = 'NotificationsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i21.NotificationsView(
        key: args.key,
        canSendNotification: args.canSendNotification,
      );
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({this.key, required this.canSendNotification});

  final _i34.Key? key;

  final bool canSendNotification;

  @override
  String toString() {
    return 'NotificationsRouteArgs{key: $key, canSendNotification: $canSendNotification}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationsRouteArgs) return false;
    return key == other.key && canSendNotification == other.canSendNotification;
  }

  @override
  int get hashCode => key.hashCode ^ canSendNotification.hashCode;
}

/// generated route for
/// [_i22.PointsView]
class PointsRoute extends _i33.PageRouteInfo<void> {
  const PointsRoute({List<_i33.PageRouteInfo>? children})
    : super(PointsRoute.name, initialChildren: children);

  static const String name = 'PointsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i22.PointsView();
    },
  );
}

/// generated route for
/// [_i23.PrivacyPolicyView]
class PrivacyPolicyRoute extends _i33.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i33.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i23.PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [_i24.ProfileView]
class ProfileRoute extends _i33.PageRouteInfo<void> {
  const ProfileRoute({List<_i33.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i24.ProfileView();
    },
  );
}

/// generated route for
/// [_i25.ResetPasswordView]
class ResetPasswordRoute extends _i33.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i34.Key? key,
    required _i41.AuthCubit authCubit,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, authCubit: authCubit),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i25.ResetPasswordView(key: args.key, authCubit: args.authCubit);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.authCubit});

  final _i34.Key? key;

  final _i41.AuthCubit authCubit;

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
/// [_i26.SelectPlanView]
class SelectPlanRoute extends _i33.PageRouteInfo<void> {
  const SelectPlanRoute({List<_i33.PageRouteInfo>? children})
    : super(SelectPlanRoute.name, initialChildren: children);

  static const String name = 'SelectPlanRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i26.SelectPlanView();
    },
  );
}

/// generated route for
/// [_i27.SettingsView]
class SettingsRoute extends _i33.PageRouteInfo<void> {
  const SettingsRoute({List<_i33.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i27.SettingsView();
    },
  );
}

/// generated route for
/// [_i28.SignInView]
class SignInRoute extends _i33.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i34.Key? key,
    _i34.VoidCallback? onSignedIn,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, onSignedIn: onSignedIn),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i28.SignInView(key: args.key, onSignedIn: args.onSignedIn);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.onSignedIn});

  final _i34.Key? key;

  final _i34.VoidCallback? onSignedIn;

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
/// [_i29.SplashView]
class SplashRoute extends _i33.PageRouteInfo<void> {
  const SplashRoute({List<_i33.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i29.SplashView();
    },
  );
}

/// generated route for
/// [_i30.TermsAndConditionsView]
class TermsAndConditionsRoute extends _i33.PageRouteInfo<void> {
  const TermsAndConditionsRoute({List<_i33.PageRouteInfo>? children})
    : super(TermsAndConditionsRoute.name, initialChildren: children);

  static const String name = 'TermsAndConditionsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i30.TermsAndConditionsView();
    },
  );
}

/// generated route for
/// [_i31.UserNavigationView]
class UserNavigationRoute extends _i33.PageRouteInfo<void> {
  const UserNavigationRoute({List<_i33.PageRouteInfo>? children})
    : super(UserNavigationRoute.name, initialChildren: children);

  static const String name = 'UserNavigationRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i31.UserNavigationView();
    },
  );
}

/// generated route for
/// [_i32.UsersView]
class UsersRoute extends _i33.PageRouteInfo<void> {
  const UsersRoute({List<_i33.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i32.UsersView();
    },
  );
}
