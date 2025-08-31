import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class ContactOptionsWidget extends StatelessWidget {
  const ContactOptionsWidget({super.key, this.setting});
  final SettingsModel? setting;

  Future<void> onLaunchPhoneTap(
      BuildContext context, String? whatsappPhone) async {
    if (whatsappPhone == null || whatsappPhone.isEmpty) return;

    final cleaned = whatsappPhone.replaceAll(RegExp(r'[^\d]'), '');
    final message = Uri.encodeComponent("مرحباً، أحتاج كود الاشتراك");
    final url = "https://wa.me/$cleaned?text=$message";

    final success =
        await launchUrlString(url, mode: LaunchMode.externalApplication);
    if (!success && context.mounted) {
      MainSnackBar.showErrorMessage(context, "cant_open_whatsapp".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: AppConstants.padding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "additional_options".tr(),
                    style: context.tt.headlineMedium,
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.phone),
                  onPressed: () =>
                      onLaunchPhoneTap(context, setting?.supportPhoneNumber),
                  label: Text(
                    "contact_customer_service".tr(),
                    style: context.tt.titleMedium?.copyWith(
                      color: context.cs.primary,
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.phone),
                  onPressed: () => onLaunchPhoneTap(
                      context, setting?.psychologicalPhoneNumber),
                  label: Text(
                    "contact_psycological_support".tr(),
                    style: context.tt.titleMedium?.copyWith(
                      color: context.cs.primary,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
