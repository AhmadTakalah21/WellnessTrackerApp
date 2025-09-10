import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
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

  Uri get _editUrl =>
      Uri.parse('https://docs.google.com/document/d/$_docId/edit?usp=sharing');
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
    final List<List<String>> keys = [
      ['privacy_data_collection', "privacy_data_collection_text"],
      ['privacy_use_of_data', "privacy_use_of_data_text"],
      ['privacy_security', "privacy_security_text"],
      ['privacy_user_rights', "privacy_user_rights_text"],
      ['privacy_policy_changes', "privacy_policy_changes_text"],
    ];
    return Scaffold(
      appBar: AppBar(title: Text('privacy_policy'.tr())),
      body: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            for (int index = 0; index < keys.length; index++) ...[
              Text(keys[index][0].tr(), style: context.tt.titleLarge),
              const SizedBox(height: 4),
              Text(keys[index][1].tr(), style: context.tt.bodyLarge),
              Divider(
                color: index.isOdd ? Colors.green : Colors.grey[350],
                thickness: 12,
                height: 50,
                indent: 10,
                endIndent: 10,
              ),
            ],
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
