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
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class NotificationsViewCallBacks {
  void onAddTap();
  void onTryAgainTap(bool isLoadMore);
  bool onNotification(ScrollNotification scrollInfo);
  void onTabSelected(int index);
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
    with SingleTickerProviderStateMixin
    implements NotificationsViewCallBacks {
  late final NotificationsCubit notificationsCubit = context.read();
  late final locale = context.locale;

  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  final List<String> tabBarTitles = ["sent", "received"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationsCubit.getNotifications(widget.role, locale);
    });
    tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      notificationsCubit.getNotifications(widget.role, locale);
    }
    return true;
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  onAddTap() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => AddNotificationView(
        notificationsCubit: notificationsCubit,
        role: widget.role,
        onSuccess: () => onTryAgainTap(false),
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap(false);

  @override
  void onTryAgainTap(bool isLoadMore) => notificationsCubit
      .getNotifications(widget.role, locale, isLoadMore: isLoadMore);

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications'.tr())),
      body: SafeArea(
        top: false,
        child: BlocBuilder<NotificationsCubit, GeneralNotificationsState>(
          buildWhen: (previous, current) => current is NotificationsState,
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return LoadingIndicator();
            } else if (state is NotificationsSuccess) {
              final sent = state.notifications
                  .where((element) => !element.received)
                  .toList();
              final received = state.notifications
                  .where((element) => element.received)
                  .toList();
              final notifications = selectedTab == 0 ? sent : received;
              if (widget.role.isUser) {
                return _buildNotifications(
                  state.notifications,
                  state.isLoadingMore,
                  state.message,
                  isError: state.isError,
                );
              }
              return Column(
                children: [
                  MainTabBar(
                    titles: tabBarTitles,
                    tabController: tabController,
                    onTapSelected: onTabSelected,
                    selectedTab: selectedTab,
                    isScrollable: false,
                  ),
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: onTabSelected,
                      itemCount: tabBarTitles.length,
                      itemBuilder: (context, index) => KeepAliveWidget(
                        child: notifications.isEmpty
                            ? MainErrorWidget(
                                isRefresh: true,
                                error: "no_notifications".tr(),
                                onTryAgainTap: () => onTryAgainTap(false),
                              )
                            : _buildNotifications(
                                notifications,
                                state.isLoadingMore,
                                state.message,
                                isError: state.isError,
                              ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is NotificationsEmpty) {
              return MainErrorWidget(
                isRefresh: true,
                error: state.message,
                onTryAgainTap: () => onTryAgainTap(false),
              );
            } else if (state is NotificationsFail) {
              return MainErrorWidget(
                error: state.error,
                onTryAgainTap: () => onTryAgainTap(false),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton:
          !widget.role.isUser ? MainFloatingButton(onTap: onAddTap) : null,
    );
  }

  Widget _buildNotifications(
    List<NotificationModel> notifications,
    bool isLoadMore,
    String? message, {
    bool isError = false,
  }) {
    return RefreshIndicator(
      notificationPredicate: onNotification,
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: AppConstants.paddingH20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ..._buildNotificationsList(notifications, isLoadMore: isLoadMore),
            if (isLoadMore) LoadingIndicator(),
            if (message != null && notifications.length >= 6)
              MainErrorWidget(
                error: message,
                onTryAgainTap: isError ? () => onTryAgainTap(true) : null,
              ),
            if (notifications.length < 6)
              SizedBox(height: (6 - notifications.length) * 100.0),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationsList(
    List<NotificationModel> notifications, {
    bool isLoadMore = false,
  }) {
    Widget initialImage = Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: context.cs.surface,
        borderRadius: AppConstants.borderRadius5,
        boxShadow: [
          BoxShadow(
            color: context.cs.onTertiary.withValues(alpha: 0.3),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Icon(
        Icons.account_balance_wallet,
        size: 24,
        color: Colors.green,
      ),
    );

    int offset = 0;
    return notifications.asMap().entries.map((entry) {
      final ind = entry.key;
      if (ind + notificationsCubit.lastBatchLength <=
          notifications.length - notificationsCubit.lastBatchLength) {
        offset++;
      }
      final notification = entry.value;
      return TileSlideAnimation(
        index: offset,
        child: _buildNotificationTile(notification, initialImage),
      );
    }).toList();
  }

  Widget _buildNotificationTile(
    NotificationModel notification,
    Widget initialImage,
  ) {
    Widget image;
    if (notification.image != null) {
      image = Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: AppImageWidget(
          url: notification.image!,
          width: 48,
          height: 48,
          borderRadius: AppConstants.borderRadius5,
          backgroundColor: context.cs.surface,
          shadows: [
            BoxShadow(
              color: context.cs.onTertiary.withValues(alpha: 0.3),
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
          errorWidget: Icon(
            Icons.account_balance_wallet,
            size: 24,
            color: Colors.green,
          ),
        ),
      );
    } else {
      image = initialImage;
    }
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
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
                  Text(notification.message, style: context.tt.bodyLarge)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
