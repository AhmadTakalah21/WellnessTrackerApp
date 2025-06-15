import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import '../../../Widgets/detailstext1.dart';
import '../../../Widgets/detailstext2.dart';
import '../../../Widgets/text11.dart';

class CryptoNotifications extends StatefulWidget {
  const CryptoNotifications({super.key, required this.canSendNotification});

  final bool canSendNotification;

  @override
  State<CryptoNotifications> createState() => _CryptoNotificationsState();
}

class _CryptoNotificationsState extends State<CryptoNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('notifications'.tr(), style: context.tt.titleLarge),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              color: context.cs.onSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text11(text2: '3 جديد', color: context.cs.primary),
          ),
          SizedBox(width: 10),
        ],
      ),
      backgroundColor: context.cs.onSurface,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text1(text1: 'اليوم'),
                          Text11(
                            text2: 'تمييز كمقروء',
                            color: context.cs.primary,
                          ),
                        ],
                      ),
                    ),
                    ..._buildNotifications(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          widget.canSendNotification
              ? Padding(
                padding: AppConstants.padding8,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppConstants.borderRadiusCircle,
                  ),
                  onPressed: () {},
                  child: Icon(Icons.add, color: context.cs.secondary, size: 30),
                ),
              )
              : null,
    );
  }

  List<Widget> _buildNotifications() {
    return List.generate(_notifications.length, (index) {
      final notification = _notifications[index];
      return Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: notification['iconBackgroundColor'],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  notification['icon'],
                  size: 24,
                  color: notification['iconColor'],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text1(text1: notification['title']),
                    Text2(text2: notification['content']),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 22 , horizontal: 4),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
    {
      'icon': Icons.account_balance_wallet,
      'iconColor': Colors.green,
      'iconBackgroundColor': Colors.green.shade100,
      'title': 'نقاط',
      'content': 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    },
   
  ];
}
