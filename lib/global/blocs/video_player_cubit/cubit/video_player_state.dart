part of 'video_player_cubit.dart';

@immutable
abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerLoaded extends VideoPlayerState {
  final VideoPlayerController controller;
  VideoPlayerLoaded(this.controller);
}

class VideoPlayerError extends VideoPlayerState {
  final String message;
  VideoPlayerError(this.message);
}