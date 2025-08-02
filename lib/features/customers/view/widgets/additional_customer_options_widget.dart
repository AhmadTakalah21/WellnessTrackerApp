import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class AdditionalCustomerOptionsWidget extends StatelessWidget {
  const AdditionalCustomerOptionsWidget({
    super.key,
    required this.onAddPoints,
    required this.assignPlanText,
    required this.onAssignPlan,
  });

  final void Function() onAddPoints;
  final String assignPlanText;
  final void Function() onAssignPlan;

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
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: onAddPoints,
                  label: Text(
                    "add_points".tr(),
                    style: context.tt.titleMedium?.copyWith(
                      color: context.cs.primary,
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.edit),
                  onPressed: onAssignPlan,
                  label: Text(
                    assignPlanText.tr(),
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
