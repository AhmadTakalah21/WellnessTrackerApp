part of '../notifications_cubit.dart';

@immutable
class AddNotificationState extends GeneralNotificationsState {}

final class AddNotificationLoading extends AddNotificationState {}

final class AddNotificationSuccess extends AddNotificationState {
  final String message;

  AddNotificationSuccess(this.message);
}

final class AddNotificationFail extends AddNotificationState {
  final String error;

  AddNotificationFail(this.error);
}
