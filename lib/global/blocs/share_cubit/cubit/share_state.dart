part of 'share_cubit.dart';

@immutable
sealed class ShareState {}

final class ShareInitial extends ShareState {}

final class ShareLoading extends ShareState {}

final class ShareSuccess extends ShareState {}

final class ShareFail extends ShareState {
  final String error;

  ShareFail(this.error);
}
