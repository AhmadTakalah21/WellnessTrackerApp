part of '../notifications_cubit.dart';

@immutable
class UnreadNotificationsCountState extends GeneralNotificationsState {}

final class UnreadNotificationsCountLoading
    extends UnreadNotificationsCountState {}

final class UnreadNotificationsCountSuccess
    extends UnreadNotificationsCountState {
  final int count;
  UnreadNotificationsCountSuccess(this.count);
}

final class UnreadNotificationsCountFail extends UnreadNotificationsCountState {
  final String error;

  UnreadNotificationsCountFail(this.error);
}
