import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum UserRoleEnum implements DropDownItemModel {
  admin,
  user,
  doctor,
  coach,
  dietitian,
  psychologist;

  @override
  String get displayName => name.tr();

  static UserRoleEnum fromJson(String role) =>
      values.firstWhere((value) => value.name == role, orElse: () => user);

  static String toJson(UserRoleEnum role) => role.name;

  String get getApiRoute {
    switch (this) {
      case admin:
        return "admin";
      case user:
        return "users";
      case doctor:
        return "doctor";
      case coach:
        return "coach";
      case dietitian:
        return "dietitian";
      case psychologist:
        return "psychologist";
    }
  }

  bool get isUser => this == user;
  bool get isAdmin => this == admin;
  bool get isDietitian => this == dietitian;
  bool get isCoach => this == coach;
  bool get isDoctor => this == doctor;
  bool get isPsychologist => this == psychologist;

  List<UserViewOnPermissionModel> getPermissions(bool isV1) {
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
            title: "points_managements",
            icon: Icons.stacked_bar_chart,
            screen: EarnPointsWaysRoute(role: this),
            color: Colors.brown,
          ),
          UserViewOnPermissionModel(
            title: "adds_and_offers",
            icon: Icons.campaign,
            screen: AddsAndOffersRouter(),
            color: Colors.orange,
          ),
          UserViewOnPermissionModel(
            title: "statistics",
            icon: Icons.bar_chart,
            screen: StatisticsRoute(),
            color: Colors.teal,
          ),
          UserViewOnPermissionModel(
            title: "ratings",
            icon: Icons.star_rate,
            screen: RatingsRoute(),
            color: Colors.amber,
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
            screen: SettingsRoute(role: this),
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
          if (isV1)
            UserViewOnPermissionModel(
              title: "points",
              icon: Icons.stacked_bar_chart,
              screen: PointsRoute(role: this),
              color: Colors.purple,
            ),
          UserViewOnPermissionModel(
            title: "meals",
            icon: Icons.restaurant_menu_rounded,
            screen: MealsRoute(role: this),
            color: Colors.green.shade400,
          ),
          UserViewOnPermissionModel(
            title: "exercises",
            icon: Icons.fitness_center_rounded,
            screen: ExercisesRoute(role: this),
            color: Colors.blue.shade400,
          ),
          if (isV1)
          UserViewOnPermissionModel(
            title: "levels",
            icon: Icons.stacked_line_chart,
            screen: LevelsRoute(role: this),
            color: Colors.orange,
          ),
          if (isV1)
            UserViewOnPermissionModel(
              title: "store",
              icon: Icons.storefront_outlined,
              screen: ItemsRoute(role: this),
              color: Colors.greenAccent,
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
          UserViewOnPermissionModel(
            title: "settings",
            icon: Icons.settings,
            screen: SettingsRoute(role: this),
            color: Colors.black,
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
            title: "exercises",
            icon: Icons.fitness_center_rounded,
            screen: ExercisesCoachRoute(role: this),
            color: Colors.blue.shade400,
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
            screen: SettingsRoute(role: this),
            color: Colors.black,
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
            title: "meals",
            icon: Icons.restaurant_menu_rounded,
            screen: MealsDietitianRoute(),
            color: Colors.green.shade400,
          ),
          UserViewOnPermissionModel(
            title: "ingredients",
            icon: Icons.kitchen,
            screen: IngredientsRoute(),
            color: Colors.blueAccent,
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
            screen: SettingsRoute(role: this),
            color: Colors.black,
          ),
        ];
      case psychologist:
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
          UserViewOnPermissionModel(
            title: "settings",
            icon: Icons.settings,
            screen: SettingsRoute(role: this),
            color: Colors.black,
          ),
        ];
    }
  }

  @override
  String get displayEntityName {
    switch (this) {
      case dietitian:
        return "nutrition".tr();
      case coach:
        return "sport".tr();
      case doctor:
        return "medicine".tr();
      case admin:
        return "admin".tr();
      case user:
        return "user".tr();
      case psychologist:
        return "psychology".tr();
    }
  }

  @override
  int get id => index + 1;
}
