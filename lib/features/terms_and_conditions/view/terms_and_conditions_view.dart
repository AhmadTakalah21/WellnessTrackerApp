import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('terms_and_conditions'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('terms_acceptance'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('terms_acceptance_text'.tr()),
            Divider(height: 30),
            Text('terms_permitted_use'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('terms_permitted_use_text'.tr()),
            Text('terms_prohibited_use_text'.tr()),
            Divider(height: 30),
            Text('terms_liability'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('terms_liability_text'.tr()),
            Text('terms_user_content_responsibility'.tr()),
            Divider(height: 30),
            Text('terms_modifications'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('terms_modifications_text'.tr()),
            Divider(height: 30),
            Text('terms_termination'.tr(), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('terms_termination_text'.tr()),
          ],
        ),
      ),
    );
  }
}
