import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';

final fakeNotifications = List.generate(
  10,
  (index) => NotificationModel(
    id: index + 1,
    title: "title for notification ${index + 1}",
    isSent: index.isEven,
    received: index.isOdd,
    createdAt: DateTime.now(),
    message: "message for notification ${index + 1}",
  ),
);
