// import 'package:auto_route/auto_route.dart';
// import 'package:chewie/chewie.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

// @RoutePage()
// class VideoPlayerView extends StatefulWidget {
//   const VideoPlayerView({super.key, required this.url});
//   final String url;

//   @override
//   State<VideoPlayerView> createState() => _VideoPlayerViewState();
// }

// class _VideoPlayerViewState extends State<VideoPlayerView> {
//   late VideoPlayerController _videoCtrl;
//   ChewieController? _chewieCtrl;
//   bool _loading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   void onTryAgainTap() {
//     setState(() {
//       _loading = true;
//       _errorMessage = null;
//     });
//     _init();
//   }

//   Future<void> _init() async {
//     try {
//       _videoCtrl = VideoPlayerController.networkUrl(Uri.parse(widget.url));
//       await _videoCtrl.initialize();
//       _chewieCtrl = ChewieController(
//         videoPlayerController: _videoCtrl,
//         fullScreenByDefault: true,
//         autoPlay: true,
//         looping: false,
//         allowFullScreen: true,
//         allowMuting: true,
//         materialProgressColors: ChewieProgressColors(),
//         errorBuilder: (context, errorMessage) {
//           return Center(child: Text(errorMessage));
//         },
//       );
//       if (mounted) setState(() => _loading = false);
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _loading = false;
//           _errorMessage = "Failed to load video: $e";
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _chewieCtrl?.dispose();
//     _videoCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('video'.tr())),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? MainErrorWidget(
//                   error: "fail_to_load_video".tr(),
//                   onTryAgainTap: onTryAgainTap,
//                 )
//               : Center(
//                   child: AspectRatio(
//                     aspectRatio: _videoCtrl.value.aspectRatio == 0
//                         ? 16 / 9
//                         : _videoCtrl.value.aspectRatio,
//                     child: Chewie(controller: _chewieCtrl!),
//                   ),
//                 ),
//     );
//   }
// }


import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/global/blocs/video_player_cubit/cubit/video_player_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

@RoutePage()
class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<VideoPlayerCubit>()..loadVideo(url),
      child: Scaffold(
        appBar: AppBar(title: Text('video'.tr())),
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoPlayerError) {
              return MainErrorWidget(
                error: "fail_to_load_video".tr(),
                onTryAgainTap: () =>
                    context.read<VideoPlayerCubit>().loadVideo(url),
              );
            } else if (state is VideoPlayerLoaded) {
              final chewieCtrl = ChewieController(
                videoPlayerController: state.controller,
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
              return Center(
                child: AspectRatio(
                  aspectRatio: state.controller.value.aspectRatio == 0
                      ? 16 / 9
                      : state.controller.value.aspectRatio,
                  child: Chewie(controller: chewieCtrl),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}