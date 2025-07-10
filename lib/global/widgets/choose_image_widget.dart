import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({
    super.key,
    required this.onTap,
    this.readOnly = false,
    this.filePath,
    this.label = "image",
    this.validator,
    this.initialImage,
  });
  final String? initialImage;
  final VoidCallback onTap;
  final bool readOnly;
  final String? filePath;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final filePath = this.filePath;
    final initialImage = this.initialImage;
    final hasImage = filePath != null && File(filePath).existsSync();

    return FormField(
      validator: validator,
      builder: (field) {
        final hasError = field.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.tr(), style: context.tt.titleLarge),
            const SizedBox(height: 10),
            InkWell(
              onTap: readOnly ? null : onTap,
              child: Container(
                padding: AppConstants.padding12,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: hasError ? 1 : 2,
                    color: hasError ? context.cs.error : context.cs.primary,
                  ),
                  borderRadius: AppConstants.borderRadius10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                             Icon(Icons.image, color: context.cs.primary),
                            const SizedBox(width: 8),
                            Text(
                              filePath == null
                                  ? 'choose_image'.tr()
                                  : 'chosen_image'.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        if (filePath != null) Expanded(child: Text(filePath)),
                      ],
                    ),
                    hasImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : const SizedBox.shrink(),
                    if (initialImage != null && !hasImage)
                      AppImageWidget(
                        url: initialImage,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorWidget: SizedBox.shrink(),
                      )
                  ],
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
