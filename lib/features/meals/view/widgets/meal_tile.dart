import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/ingredients/view/widgets/nutrients_widget.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/video_player_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/video_preview_widget.dart';

class MealTile extends StatelessWidget {
  const MealTile({super.key, required this.meal, this.onTap});
  final MealModel meal;
  final void Function(MealModel meal)? onTap;

  @override
  Widget build(BuildContext context) {
    final link = Utils.absoluteLink(meal.link);
    return InkWell(
      onTap: () => onTap?.call(meal),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  meal.type.displayName,
                  style: context.tt.headlineMedium?.copyWith(
                    color: context.cs.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    meal.name,
                    style: context.tt.titleLarge?.copyWith(
                      color: context.cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...meal.ingredients.map(
                (ingredient) => _buildIngredients(context, ingredient),
              ),
              Padding(
                padding: AppConstants.paddingH20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${"prepare_method".tr()} :",
                            style: context.tt.titleMedium),
                        if (meal.link.isNotEmpty)
                          IconButton(
                            tooltip: 'open_instruction'.tr(),
                            icon: Icon(
                              Utils.iconForLink(meal.link),
                              color: context.cs.primary,
                              size: 30,
                            ),
                            onPressed: () => Utils.onOpenMedia(context,
                                meal.link, (url) => VideoPlayerView(url: url)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(meal.description, style: context.tt.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredients(
    BuildContext context,
    IngredientWithQuantityModel ingredientWithQnt,
  ) {
    final ingredient = ingredientWithQnt.ingredient;
    return Container(
      margin: AppConstants.paddingV10,
      padding: AppConstants.padding12,
      decoration: BoxDecoration(
        color: context.cs.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ingredient.name,
            style: context.tt.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          NutrientsWidget(
            ingredient: ingredient,
            quantity: ingredientWithQnt.quantity,
          ),
        ],
      ),
    );
  }
}
