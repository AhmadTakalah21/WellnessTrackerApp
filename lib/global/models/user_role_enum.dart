import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/features/codes/view/codes_view.dart';
import 'package:wellnesstrackerapp/features/customers/view/customers_view.dart';
import 'package:wellnesstrackerapp/features/exercises/view/exercises_view.dart';
import 'package:wellnesstrackerapp/features/items/view/items_view.dart';
import 'package:wellnesstrackerapp/features/levels/view/levels_view.dart';
import 'package:wellnesstrackerapp/features/meals/view/meals_view.dart';
import 'package:wellnesstrackerapp/features/points/view/points_view.dart';
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart';
import 'package:wellnesstrackerapp/features/users/view/users_view.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/views/daillygoals/daillygoals.dart';
import 'package:wellnesstrackerapp/views/notifications/notifications.dart';

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
    } else if (role == "dietician") {
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
      return "dietician";
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
            screen: CustomersView(),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "employees_administration",
            icon: Icons.manage_accounts,
            screen: UsersView(),
            color: Colors.blue,
          ),
          UserViewOnPermissionModel(
            title: "codes_management",
            icon: Icons.qr_code,
            screen: CodesView(),
            color: Colors.purple,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: CryptoNotifications(canSendNotification: true),
            color: Colors.green,
          ),
        ];
      case UserRoleEnum.user:
        return [
          UserViewOnPermissionModel(
            title: "follow_up",
            icon: FontAwesomeIcons.clipboardList,
            screen: SelectPlanView(),
            color: Colors.blue,
          ),
          UserViewOnPermissionModel(
            title: "daily_goals",
            icon: FontAwesomeIcons.listCheck,
            screen: DailyGoalsScreen(),
            color: Colors.green,
          ),
          UserViewOnPermissionModel(
            title: "points",
            icon: Icons.stacked_bar_chart,
            screen: PointsView(),
            color: Colors.purple,
          ),
          UserViewOnPermissionModel(
            title: "meals",
            icon: Icons.restaurant_menu_rounded,
            screen: MealsView(),
            color: Colors.green.shade400,
          ),
          UserViewOnPermissionModel(
            title: "exercises",
            icon: Icons.fitness_center_rounded,
            screen: ExercisesView(),
            color: Colors.blue.shade400,
          ),
          UserViewOnPermissionModel(
            title: "levels",
            icon: Icons.stacked_line_chart,
            screen: LevelsView(),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "store",
            icon: Icons.storefront_outlined,
            screen: ItemsView(),
            color: Colors.greenAccent,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: CryptoNotifications(canSendNotification: false),
            color: Colors.green,
          ),
        ];
      case UserRoleEnum.doctor:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersView(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.coach:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersView(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.nutritionist:
        return [
          UserViewOnPermissionModel(
            title: "customers_administration",
            icon: Icons.admin_panel_settings,
            screen: CustomersView(),
            color: Colors.red,
          ),
        ];
    }
  }
}
