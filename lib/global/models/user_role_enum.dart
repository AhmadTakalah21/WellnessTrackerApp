import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/features/points/view/points_view.dart';
import 'package:wellnesstrackerapp/features/select_plan/view/select_plan_view.dart';
import 'package:wellnesstrackerapp/features/users/view/users_view.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/views/activitiestracking/actvity.dart';
import 'package:wellnesstrackerapp/views/daillygoals/daillygoals.dart';
import 'package:wellnesstrackerapp/views/notifications/notifications.dart';

enum UserRoleEnum {
  admin,
  user,
  doctor,
  coach,
  nutritionist;

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
            title: "user_administration",
            icon: Icons.admin_panel_settings,
            screen: ActivityScreen(),
            color: Colors.red,
          ),
          UserViewOnPermissionModel(
            title: "employees_administration",
            icon: Icons.manage_accounts,
            screen: UsersView(),
            //screen: Bp1(),
            color: Colors.blue,
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
            title: "select_plan",
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
            icon: FontAwesomeIcons.shoePrints,
            screen: PointsView(),
            color: Colors.purple,
          ),
          UserViewOnPermissionModel(
            title: "notifications",
            icon: FontAwesomeIcons.bell,
            screen: CryptoNotifications(canSendNotification: true),
            color: Colors.green,
          ),
        ];
      case UserRoleEnum.doctor:
        return [
          UserViewOnPermissionModel(
            title: "user_administration",
            icon: Icons.admin_panel_settings,
            screen: ActivityScreen(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.coach:
        return [
          UserViewOnPermissionModel(
            title: "user_administration",
            icon: Icons.admin_panel_settings,
            screen: ActivityScreen(),
            color: Colors.red,
          ),
        ];
      case UserRoleEnum.nutritionist:
        return [
          UserViewOnPermissionModel(
            title: "user_administration",
            icon: Icons.admin_panel_settings,
            screen: ActivityScreen(),
            color: Colors.red,
          ),
          // TODO remove points , jsut for tset
          UserViewOnPermissionModel(
            title: "select_plan",
            icon: FontAwesomeIcons.clipboardList,
            screen: SelectPlanView(),
            color: Colors.blue,
          ),
          // TODO remove points , jsut for tset
          UserViewOnPermissionModel(
            title: "points",
            icon: FontAwesomeIcons.shoePrints,
            screen: PointsView(),
            color: Colors.purple,
          ),
        ];
    }
  }
}
