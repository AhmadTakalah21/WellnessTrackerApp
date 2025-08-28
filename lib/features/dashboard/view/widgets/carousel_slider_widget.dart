import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/adv_details_widget.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.controller,
    required this.items,
    required this.indexListenable,
    required this.onPageChanged,
  });
  final PageController controller;
  final List<AdvModel> items;
  final ValueListenable<int> indexListenable;
  final ValueChanged<int> onPageChanged;

  void onAdvTap(BuildContext context, AdvModel adv) {
    showDialog(
      context: context,
      builder: (context) {
        return AdvDetailsWidget(adv: adv, role: UserRoleEnum.user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: items.length,
            itemBuilder: (_, i) {
              final adv = items[i];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: RepaintBoundary(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        InkWell(
                          onTap: () => onAdvTap(context, adv),
                          child: AppImageWidget(
                            url: adv.image,
                            backgroundColor: context.cs.surface,
                            borderRadius: AppConstants.borderRadius20,
                            errorWidget:
                                Image.asset("assets/images/app_logo.png"),
                            fit: BoxFit.cover,
                            shadows: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                color: AppColors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder<int>(
          valueListenable: indexListenable,
          builder: (_, index, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                items.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == index ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == index
                        ? theme.colorScheme.primary
                        : Colors.black.withOpacity(.15),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
