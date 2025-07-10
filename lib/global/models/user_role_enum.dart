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
  nutritionist;

  String get displayName => name.tr();

  static UserRoleEnum fromJson(String role) {
    if (role == "admin") {
      return UserRoleEnum.admin;
    } else if (role == "user") {
      return UserRoleEnum.user;
    } else if (role == "doctor") {
      return UserRoleEnum.doctor;
    } else if (role == "coach") {
      return UserRoleEnum.coach;
    } else if (role == "dietitian") {
      return UserRoleEnum.nutritionist;
    } else {
      //throw 'Role is not supported';
      return UserRoleEnum.user;
    }
  }

  static String toJson(UserRoleEnum role) {
    if (role == UserRoleEnum.admin) {
      return "admin";
    } else if (role == UserRoleEnum.user) {
      return "user";
    } else if (role == UserRoleEnum.doctor) {
      return "doctor";
    } else if (role == UserRoleEnum.coach) {
      return "coach";
    } else if (role == UserRoleEnum.nutritionist) {
      return "dietitian";
    } else {
      //throw 'Role is not supported';
      return "user";
    }
  }

  List<UserViewOnPermissionModel> get getPermissions {
    switch (this) {
      case UserRoleEnum.admin:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(),
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
            screen: LevelsRoute(),
            color: Colors.indigo,
          ),
          UserViewOnPermissionModel(
            title: "adds_and_offers",
            icon: Icons.campaign,
            screen: AddsAndOffersRoute(role: admin),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "company_info",
            icon: Icons.info,
            screen: CompanyInfoRoute(),
            color: Colors.greenAccent,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(canSendNotification: true),
            color: Colors.green,
          ),
        ];
      case UserRoleEnum.user:
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
            screen: LevelsRoute(),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "store",
            icon: Icons.storefront_outlined,
            screen: ItemsRoute(),
            color: Colors.greenAccent,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: NotificationsRoute(canSendNotification: false),
            color: Colors.green,
          ),
        ];
      case UserRoleEnum.doctor:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.coach:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.nutritionist:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersRoute(),
            color: Colors.red,
          ),
        ];
    }
  }
}
