import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/notifications/cubit/notifications_cubit.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/view/widgets/add_notification_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

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

  final List<NotificationModel> _notifications = List.generate(
    8,
    (index) => NotificationModel(
      id: index + 1,
      title: 'نقاط',
      body: 'تم زيادة 5  نقاط نتيجة خفض الوزن بمقدار 1 كغ',
    ),
  );

  @override
  void initState() {
    super.initState();
    notificationsCubit.getNotifications(widget.role);
  }

  @override
  onAddTap() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => AddNotificationView(
        notificationsCubit: notificationsCubit,
        role: widget.role,
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
              color: context.cs.surface,
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
        child: BlocBuilder<NotificationsCubit, GeneralNotificationsState>(
          buildWhen: (previous, current) => current is NotificationsState,
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return LoadingIndicator();
            } else if (state is NotificationsSuccess ||
                state is NotificationsFail ||
                state is NotificationsEmpty) {
              return Padding(
                padding: AppConstants.paddingH8,
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    padding: AppConstants.padding10,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                        SizedBox(height: 10),
                        ..._buildNotifications(_notifications),
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is NotificationsEmpty) {
              return MainErrorWidget(
                isRefresh: true,
                error: state.message,
                onTryAgainTap: onTryAgainTap,
              );
            } else if (state is NotificationsFail) {
              return MainErrorWidget(
                error: state.error,
                onTryAgainTap: onTryAgainTap,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton: !widget.role.isUser
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

  List<Widget> _buildNotifications(List<NotificationModel> notifications) {
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
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 24,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: context.tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(notification.body, style: context.tt.bodyLarge)
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
}
