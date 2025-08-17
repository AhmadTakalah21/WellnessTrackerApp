import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class PrivacyPolicyViewCallBacks {
  Future<void> onTap();
}

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

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage>
    implements PrivacyPolicyViewCallBacks {
  static const _docId = '1qGe66yBqlY49q1M_G_IMk-tf-QLKKEbNv_F8W2usPDY';

  Uri get _editUrl => Uri.parse(
      'https://docs.google.com/document/d/$_docId/edit?usp=sharing');
  Uri get _viewUrl =>
      Uri.parse('https://docs.google.com/document/d/$_docId/view?usp=sharing');
  Uri get _pdfUrl =>
      Uri.parse('https://docs.google.com/document/d/$_docId/export?format=pdf');

  Future<bool> _tryLaunch(Uri url) async {
    if (await canLaunchUrl(url)) {
      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
        return true;
      }
    }
    if (await launchUrl(url, mode: LaunchMode.platformDefault)) {
      return true;
    }
    if (await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      return true;
    }
    return false;
  }

  @override
  Future<void> onTap() async {
    try {
      if (await _tryLaunch(_editUrl)) return;

      if (await _tryLaunch(_viewUrl)) return;

      if (await _tryLaunch(_pdfUrl)) return;

      if (mounted) {
        MainSnackBar.showErrorMessage(context, "cant_open_url".tr());
      }
    } catch (e) {
      if (mounted) {
        MainSnackBar.showErrorMessage(context, "cant_open_url".tr());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('privacy_policy'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('privacy_data_collection'.tr(),
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_data_collection_text'.tr()),
            Text('privacy_location_data_text'.tr()),
            const Divider(height: 30),
            Text('privacy_use_of_data'.tr(),
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_use_of_data_text'.tr()),
            Text('privacy_no_third_party_share'.tr()),
            const Divider(height: 30),
            Text('privacy_security'.tr(),
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_security_text'.tr()),
            Text('privacy_security_no_guarantee'.tr()),
            const Divider(height: 30),
            Text('privacy_user_rights'.tr(),
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_user_rights_text'.tr()),
            Text('privacy_unsubscribe_text'.tr()),
            const Divider(height: 30),
            Text('privacy_policy_changes'.tr(),
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('privacy_policy_changes_text'.tr()),
            const Divider(height: 30),
            InkWell(
              onTap: onTap,
              child: Text(
                'you_can_view_privacy_policy'.tr(),
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
