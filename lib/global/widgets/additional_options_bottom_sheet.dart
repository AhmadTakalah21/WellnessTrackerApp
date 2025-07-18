import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class AdditionalOptionsBottomSheet<T> extends StatelessWidget {
  const AdditionalOptionsBottomSheet({
    super.key,
    required this.item,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  final T item;
  final void Function(T) onEditTap;
  final void Function(T) onDeleteTap;

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
                  icon: Icon(Icons.edit),
                  onPressed: () => onEditTap(item),
                  label: Text(
                    "edit".tr(),
                    style: context.tt.labelMedium?.copyWith(
                      color: context.cs.primary,
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.delete, color: context.cs.error),
                  onPressed: () => onDeleteTap(item),
                  label: Text(
                    "delete".tr(),
                    style: context.tt.labelMedium?.copyWith(
                      color: context.cs.error,
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
