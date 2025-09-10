import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

@injectable
class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  VideoPlayerController? _controller;

  Future<void> loadVideo(String url) async {
    emit(VideoPlayerLoading());
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await _controller!.initialize();
      emit(VideoPlayerLoaded(_controller!));
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}