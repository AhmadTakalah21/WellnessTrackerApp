import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class AdvDetailsWidget extends StatelessWidget {
  const AdvDetailsWidget({super.key, required this.adv, required this.role});

  final AdvModel adv;
  final UserRoleEnum role;

  void onBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale == SupportedLocales.arabic;
    final title = isArabic ? adv.title.ar : adv.title.en;
    final description = isArabic ? adv.description.ar : adv.description.en;
    final expDate = "${"exp_date".tr()}: ${adv.endDate}";
    return AlertDialog(
      contentPadding: AppConstants.padding16,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Stack(
                children: [
                  Center(
                    child: AppImageWidget(
                      width: 300,
                      borderRadius: AppConstants.borderRadius20,
                      fit: BoxFit.contain,
                      url: adv.image,
                      backgroundColor: context.cs.surface,
                      shadows: AppColors.secondShadow,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Padding(
                      padding: AppConstants.padding8,
                      child: InkWell(
                        onTap: () => onBack(context),
                        child: Icon(
                          Icons.close,
                          color: context.cs.onTertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            if (title != null && title.isNotEmpty) ...[
              Center(child: Text(title, style: context.tt.titleLarge)),
              const SizedBox(height: 15),
            ],
            if (description != null && description.isNotEmpty) ...[
              Center(child: Text(description, style: context.tt.titleSmall)),
              const SizedBox(height: 15),
            ],
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(expDate, style: context.tt.titleLarge)],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
