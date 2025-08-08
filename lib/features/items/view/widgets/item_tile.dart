import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
    required this.role,
    required this.onTap,
  });

  final ItemModel item;
  final UserRoleEnum role;
  final void Function(ItemModel item) onTap;

  @override
  Widget build(BuildContext context) {
    final userPoints = 1000;
    final progress = (userPoints / item.price).clamp(0.0, 1.0);
    final image = item.image;
    final description = item.description;

    return GestureDetector(
      onTap: () => onTap(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width / 2 - 24,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.cs.primary.withOpacity(0.9),
              context.cs.primary.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: context.cs.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (role.isUser && item.link == null)
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.lock_outline, color: Colors.white, size: 20),
              ),
            const SizedBox(height: 6),
            if (role.isUser)
              CircularPercentIndicator(
                radius: 35,
                lineWidth: 5,
                percent: progress,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.white,
                backgroundColor: Colors.white24,
                center: image != null
                    ? AppImageWidget(
                        width: 40,
                        height: 40,
                        url: image,
                        borderRadius: AppConstants.borderRadiusCircle,
                        border: Border.all(color: Colors.white, width: 1),
                      )
                    : null,
              ),
            if (role.isAdmin)
              image != null
                  ? AspectRatio(
                      aspectRatio: 5 / 3,
                      child: AppImageWidget(
                        url: image,
                        fit: BoxFit.cover,
                        borderRadius: AppConstants.borderRadius15,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: AppConstants.borderRadius15,
                      child: ColoredBox(
                        color: Colors.white,
                        child: AspectRatio(
                          aspectRatio: 5 / 3,
                          child: Image.asset(
                            "assets/images/app_logo.png",
                            color: context.cs.secondary,
                          ),
                        ),
                      ),
                    ),
            const SizedBox(height: 10),
            Text(
              item.name.en ?? "Item",
              style: context.tt.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            if (description?.en != null && description!.en!.isNotEmpty)
              Text(
                description.en!,
                style: context.tt.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "${item.price.toInt()} نقطة",
                style: GoogleFonts.poppins(
                  color: context.cs.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
