import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key, required this.url});
  final String url;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoCtrl;
  ChewieController? _chewieCtrl;
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void onTryAgainTap() {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    _init();
  }

  Future<void> _init() async {
    try {
      _videoCtrl = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await _videoCtrl.initialize();
      _chewieCtrl = ChewieController(
        videoPlayerController: _videoCtrl,
        fullScreenByDefault: true,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        materialProgressColors: ChewieProgressColors(),
        errorBuilder: (context, errorMessage) {
          return Center(child: Text(errorMessage));
        },
      );
      if (mounted) setState(() => _loading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _errorMessage = "Failed to load video: $e";
        });
      }
    }
  }

  @override
  void dispose() {
    _chewieCtrl?.dispose();
    _videoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("url is ${widget.url}");
    return Scaffold(
      appBar: AppBar(title: Text('video'.tr())),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? MainErrorWidget(
                  error: "fail_to_load_video".tr(),
                  onTryAgainTap: onTryAgainTap,
                )
              : Center(
                  child: AspectRatio(
                    aspectRatio: _videoCtrl.value.aspectRatio == 0
                        ? 16 / 9
                        : _videoCtrl.value.aspectRatio,
                    child: Chewie(controller: _chewieCtrl!),
                  ),
                ),
    );
  }
}
