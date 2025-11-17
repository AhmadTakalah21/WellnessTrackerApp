part of '../notifications_cubit.dart';

@immutable
class NotificationState extends GeneralNotificationsState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final NotificationModel notification;

  NotificationSuccess(this.notification);
}

final class NotificationFail extends NotificationState {
  final String error;

  NotificationFail(this.error);
}
