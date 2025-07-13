import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/notifications/cubit/notifications_cubit.dart';
import 'package:wellnesstrackerapp/features/notifications/view/widgets/add_notification_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class NotificationsViewCallBacks {
  void onAddTap();
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key, required this.role});

  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<NotificationsCubit>(),
      child: NotificationsPage(role: role),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key, required this.role});

  final UserRoleEnum role;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    implements NotificationsViewCallBacks {
  late final NotificationsCubit notificationsCubit = context.read();

  @override
  void initState() {
    super.initState();
    notificationsCubit.getNotifications(widget.role);
  }

  @override
  onAddTap() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (bottomSheetContext) => AddNotificationView(
        notificationsCubit: notificationsCubit,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => notificationsCubit.getNotifications(widget.role);

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
            child: Text(
              '3 جديد',
              style: context.tt.bodyLarge?.copyWith(
                color: context.cs.primary,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                          Text(
                            'اليوم',
                            style: context.tt.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'تمييز كمقروء',
                            style: context.tt.bodyLarge?.copyWith(
                              color: context.cs.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    ..._buildNotifications(),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.role.isAdmin
          ? Padding(
              padding: AppConstants.padding8,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: AppConstants.borderRadiusCircle,
                ),
                onPressed: onAddTap,
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
                    Text(
                      notification['title'],
                      style: context.tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(notification['content'], style: context.tt.bodyLarge)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 4),
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
