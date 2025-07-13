import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class AdvDetailsWidget extends StatelessWidget {
  const AdvDetailsWidget({super.key, required this.adv});

  final AdvModel adv;

  void onBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
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
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: InkWell(
                        onTap: () => onBack(context),
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                adv.description.en,
                style: context.tt.titleMedium,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"exp_date".tr()}: ${adv.endDate}",
                    style: context.tt.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
