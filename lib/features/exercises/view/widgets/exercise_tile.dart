import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/video_player_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/video_preview_widget.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({super.key, required this.exercise, this.onTap});
  final ExerciseModel exercise;
  final void Function(ExerciseModel exercise)? onTap;

  @override
  Widget build(BuildContext context) {
    final String link = Utils.absoluteLink(exercise.link);
    final desc = exercise.description;

    return InkWell(
      onTap: () => onTap?.call(exercise),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      exercise.name,
                      style: context.tt.titleLarge?.copyWith(
                        color: context.cs.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (exercise.link.isNotEmpty)
                    IconButton(
                      tooltip: 'open_instruction'.tr(),
                      icon: Icon(Utils.iconForLink(exercise.link),
                          size: 30, color: context.cs.primary),
                      onPressed: () => Utils.onOpenMedia(
                          context, link, (url) => VideoPlayerView(url: url)),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Chip(
                    avatar: const Icon(Icons.repeat),
                    label: Text('${'rounds'.tr()}: ${desc.rounds}'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (desc.repeats.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (int i = 0; i < desc.repeats.length; i++)
                      Chip(
                        label: Text(
                          '${'round'.tr()} ${i + 1}: ${desc.repeats[i]} ${'reps'.tr()}',
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: context.cs.primary),
                  const SizedBox(width: 6),
                  Text('instruction'.tr(), style: context.tt.titleMedium),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                desc.explain,
                style: context.tt.bodyMedium,
              ),
              if (link.isNotEmpty && (Utils.isVideo(link))) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Utils.onOpenMedia(
                      context, link, (url) => VideoPlayerView(url: url)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPreviewWidget(videoUrl: link),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
