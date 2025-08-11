part of '../notifications_cubit.dart';

@immutable
sealed class NotificationsState extends GeneralNotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoadingMore;
  final bool hasMore;

  NotificationsSuccess(
    this.notifications, {
    this.isLoadingMore = false,
    this.hasMore = true,
  });
}

class NotificationsEmpty extends NotificationsState {
  final String message;

  NotificationsEmpty(this.message);
}

class NotificationsFail extends NotificationsState {
  final String error;

  NotificationsFail(this.error);
}
