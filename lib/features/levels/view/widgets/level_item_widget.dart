import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class LevelItemWidget extends StatelessWidget {
  const LevelItemWidget({
    super.key,
    required this.level,
    required this.onTap,
    required this.onLongPress,
  });
  final LevelModel level;
  final void Function(LevelModel level) onTap;
  final void Function(LevelModel level) onLongPress;

  @override
  Widget build(BuildContext context) {
    final image = level.image;
    final description = level.description;
    return InkWell(
      onTap: () => onTap(level),
      onLongPress: () => onLongPress(level),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 5 / 2,
              child: image == null
                  ? Image.asset(
                    "assets/images/app_logo.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  )
                  : AppImageWidget(
                      url: image,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.name,
                    style: context.tt.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  if (description != null)
                    Text(
                      description,
                      style: context.tt.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
