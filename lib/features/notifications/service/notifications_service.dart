import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/add_notification_model/add_notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'notifications_service_imp.dart';

abstract class NotificationsService {
  Future<PaginatedModel<NotificationModel>> getNotifications(
    UserRoleEnum role, Locale locale,{
    int? perPage = 10,
    int? page,
  });

  Future<void> addNotification(
    UserRoleEnum role,
    AddNotificationModel model, {
    required List<CustomerModel> userIds,
    XFile? image,
  });
}
