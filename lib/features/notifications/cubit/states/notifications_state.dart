part of '../notifications_cubit.dart';

@immutable
sealed class NotificationsState extends GeneralNotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final PaginatedModel<NotificationModel> notifications;
  final String? emptyMessage;

  NotificationsSuccess(this.notifications, this.emptyMessage);
}

class NotificationsEmpty extends NotificationsState {
  final String message;

  NotificationsEmpty(this.message);
}

class NotificationsFail extends NotificationsState {
  final String error;

  NotificationsFail(this.error);
}
