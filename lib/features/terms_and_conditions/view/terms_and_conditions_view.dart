import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

import '../../../global/services/user_repo.dart';

@RoutePage()
class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TermsAndConditionsPage();
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late final UserRepo userRepo = context.read();

  late final List<List<String>> termsKeys = [
    ['disclaimer_title', "disclaimer_body"],
    ['terms_info_title', "terms_info"],
    if (userRepo.isV1) ['terms_start_subscription_title', "terms_start_subscription"],
    if (userRepo.isV1) ['terms_freeze_subscription_title', "terms_freeze_subscription"],
    ['terms_problem_handling_title', "terms_problem_handling"],
    ['terms_success_sharing_title', "terms_success_sharing"],
    ['terms_daily_contact_title', "terms_daily_contact"],
    ['terms_financial_title', "terms_financial"],
    ['terms_preferences_title', "terms_preferences"],
    ['terms_safe_weight_loss_title', "terms_safe_weight_loss"],
    ['terms_equal_support_title', "terms_equal_support"],
    ['terms_no_response_title', "terms_no_response"],
    ['terms_fitness_service_title', "terms_fitness_service"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("terms_and_conditions".tr())),
      body: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 5 / 2,
              child: Image.asset(AppConstants.logo, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.green,
              thickness: 12,
              height: 50,
              indent: 10,
              endIndent: 10,
            ),

            // بانر تنبيهي أنيق يظهر فقط عندما isV1
            if (userRepo.isV1) ...[
              _buildDisclaimerBanner(),
              const SizedBox(height: 12),
            ],

            // القائمة (عناوين + نصوص)
            for (int index = 0; index < termsKeys.length; index++) ...[
              Text(termsKeys[index][0].tr(), style: context.tt.titleLarge),
              const SizedBox(height: 4),
              Text(termsKeys[index][1].tr(), style: context.tt.bodyLarge),
              if (index != termsKeys.length - 1)
                Divider(
                  color: index.isOdd ? Colors.green : Colors.grey[350],
                  thickness: 12,
                  height: 50,
                  indent: 10,
                  endIndent: 10,
                ),
            ],
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // بانر الـ Disclaimer المختصر (شرطيًا)
  Widget _buildDisclaimerBanner() {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withOpacity(.25), width: 1),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primary.withOpacity(.08),
            cs.primary.withOpacity(.02),
          ],
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: cs.primary, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'disclaimer_title'.tr(),
                  style: context.tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'disclaimer_short'.tr(),
                  style: context.tt.bodyMedium?.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
