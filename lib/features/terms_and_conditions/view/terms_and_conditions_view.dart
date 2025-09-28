import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

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
    ['terms_info_title', "terms_info"],
    if (userRepo.isV1)
      ['terms_start_subscription_title', "terms_start_subscription"],
    if (userRepo.isV1)
      ['terms_freeze_subscription_title', "terms_freeze_subscription"],
    ['terms_problem_handling_title', "terms_problem_handling"],
    if (userRepo.isV1) ['terms_success_sharing_title', "terms_success_sharing"],
    ['terms_daily_contact_title', "terms_daily_contact"],
    if (userRepo.isV1) ['terms_financial_title', "terms_financial"],
    ['terms_preferences_title', "terms_preferences"],
    ['terms_safe_weight_loss_title', "terms_safe_weight_loss"],
    if (userRepo.isV1) ['terms_equal_support_title', "terms_equal_support"],
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
}
