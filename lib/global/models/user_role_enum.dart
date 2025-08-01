import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';

enum UserRoleEnum {
  admin,
  user,
  doctor,
  coach,
  dietitian;

  String get displayName => name.tr();

  static UserRoleEnum fromJson(String role) =>
      values.firstWhere((value) => value.name == role, orElse: () => user);

  static String toJson(UserRoleEnum role) => role.name;

  String get getApiRoute {
    switch (this) {
      case UserRoleEnum.admin:
        return "admin";
      case UserRoleEnum.user:
        return "users";
      case UserRoleEnum.doctor:
        return "doctor";
      case UserRoleEnum.coach:
        return "coach";
      case UserRoleEnum.dietitian:
        return "dietitian";
    }
  }

  bool get isUser => this == user;
  bool get isAdmin => this == admin;
  bool get isDietitian => this == dietitian;
  bool get isCoach => this == coach;
  bool get isDoctor => this == doctor;

  List<UserViewOnPermissionModel> get getPermissions {
    switch (this) {
      case admin:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(role: this),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "employees_administration",
            icon: Icons.manage_accounts,
            screen: UsersRoute(),
            color: Colors.blue,
          ),
          UserViewOnPermissionModel(
            title: "codes_management",
            icon: Icons.qr_code,
            screen: CodesRoute(),
            color: Colors.purple,
          ),
          UserViewOnPermissionModel(
            title: "levels",
            icon: Icons.stacked_line_chart,
            screen: LevelsRoute(role: this),
            color: Colors.indigo,
          ),
          UserViewOnPermissionModel(
            title: "adds_and_offers",
            icon: Icons.campaign,
            screen: AddsAndOffersRoute(role: this),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(role: this),
            color: Colors.green,
          ),
          UserViewOnPermissionModel(
            title: "settings",
            icon: Icons.settings,
            screen: SettingsRoute(),
            color: Colors.black,
          ),
        ];
      case user:
        return [
          UserViewOnPermissionModel(
            title: "follow_up",
            icon: FontAwesomeIcons.clipboardList,
            screen: SelectPlanRoute(),
            color: Colors.blue,
          ),
          // UserViewOnPermissionModel(
          //   title: "daily_goals",
          //   icon: FontAwesomeIcons.listCheck,
          //   screen: DailyGoalsScreen(),
          //   color: Colors.green,
          // ),
          UserViewOnPermissionModel(
            title: "points",
            icon: Icons.stacked_bar_chart,
            screen: PointsRoute(),
            color: Colors.purple,
          ),
          UserViewOnPermissionModel(
            title: "meals",
            icon: Icons.restaurant_menu_rounded,
            screen: MealsRoute(),
            color: Colors.green.shade400,
          ),
          UserViewOnPermissionModel(
            title: "exercises",
            icon: Icons.fitness_center_rounded,
            screen: ExercisesRoute(),
            color: Colors.blue.shade400,
          ),
          UserViewOnPermissionModel(
            title: "levels",
            icon: Icons.stacked_line_chart,
            screen: LevelsRoute(role: this),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "store",
            icon: Icons.storefront_outlined,
            screen: ItemsRoute(role: this),
            color: Colors.greenAccent,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(role: this),
            color: Colors.green,
          ),
        ];
      case doctor:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(role: this),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(role: this),
            color: Colors.green,
          ),
        ];
      case coach:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(role: this),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(role: this),
            color: Colors.green,
          ),
        ];
      case dietitian:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(role: this),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(role: this),
            color: Colors.green,
          ),
        ];
    }
  }
}
