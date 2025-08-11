import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrivacyPolicyPage();
  }
}

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('privacy_policy'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('privacy_data_collection'.tr(),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_data_collection_text'.tr()),
            Text('privacy_location_data_text'.tr()),
            Divider(height: 30),
            Text('privacy_use_of_data'.tr(),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_use_of_data_text'.tr()),
            Text('privacy_no_third_party_share'.tr()),
            Divider(height: 30),
            Text('privacy_security'.tr(),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_security_text'.tr()),
            Text('privacy_security_no_guarantee'.tr()),
            Divider(height: 30),
            Text('privacy_user_rights'.tr(),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_user_rights_text'.tr()),
            Text('privacy_unsubscribe_text'.tr()),
            Divider(height: 30),
            Text('privacy_policy_changes'.tr(),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_policy_changes_text'.tr()),
          ],
        ),
      ),
    );
  }
}
