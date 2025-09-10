import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';

class VideoPreviewWidget extends StatelessWidget {
  const VideoPreviewWidget({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: Utils.generateThumbnail(videoUrl),
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.connectionState == ConnectionState.waiting) {
          child = ColoredBox(
            color: Colors.black.withOpacity(0.08),
            child: LoadingIndicator(color: context.cs.secondary),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          child = Image.memory(snapshot.data!, fit: BoxFit.cover);
        } else {
          child = ColoredBox(color: Colors.black.withOpacity(0.08));
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              if (child is Image)
                const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
