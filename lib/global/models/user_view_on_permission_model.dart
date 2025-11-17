import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class UserViewOnPermissionModel {
  final String title;
  final IconData icon;
  final PageRouteInfo screen;
  final Color color;
  final bool isNotification;
  UserViewOnPermissionModel({
    required this.title,
    required this.icon,
    required this.screen,
    required this.color,
    this.isNotification = false,
  });
}
