import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/add_notification_model/add_notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/fake_notifications.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/service/notifications_service.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/general_notifications_state.dart';
part 'states/notifications_state.dart';
part 'states/notification_state.dart';
part 'states/unread_notifications_count_state.dart';
part 'states/add_notification_state.dart';

@injectable
class NotificationsCubit extends Cubit<GeneralNotificationsState> {
  NotificationsCubit(this.notificationsService)
      : super(GeneralNotificationsInitial());

  final NotificationsService notificationsService;

  List<NotificationModel> notifications = [];
  int page = 1;
  bool hasMore = true;

  bool isReceivedFilter = true;
  bool isReadFilter = false;

  int lastBatchLength = 0;

  MetaModel? meta;
  AddNotificationModel addNotificationModel = const AddNotificationModel();
  List<CustomerModel> userIds = [];
  XFile? image;

  bool scheduleByTime = false;

  void setIsReceivedFilter(bool value) => isReceivedFilter = value;
  void setIsReadFilter(bool value) => isReadFilter = value;

  void setScheduleByTime(bool value) {
    scheduleByTime = value;

    if (!scheduleByTime) {
      addNotificationModel = addNotificationModel.copyWith(
        time: () => null,
        tz: () => null,
      );
    }
  }

  void setIsAll(String? isAll) {
    addNotificationModel = addNotificationModel.copyWith(isAll: isAll);
  }

  void setUsers(List<CustomerModel> userIds) {
    this.userIds = userIds;
  }

  void clearUserIds() {
    userIds.clear();
  }

  void setTitle(String? title) {
    addNotificationModel = addNotificationModel.copyWith(title: () => title);
  }

  void setMessage(String? message) {
    addNotificationModel =
        addNotificationModel.copyWith(message: () => message);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void setTime(String? time) {
    addNotificationModel = addNotificationModel.copyWith(time: () => time);
  }

  void setTz(String? tz) {
    addNotificationModel = addNotificationModel.copyWith(tz: () => tz);
  }

  void resetAddNotificationModel() {
    addNotificationModel = const AddNotificationModel();
    scheduleByTime = false;
    image = null;
    userIds.clear();
  }

  Future<void> getNotifications(
    UserRoleEnum role,
    Locale locale, {
    int perPage = 10,
    bool isLoadMore = true,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(NotificationsSuccess(filterNotifications(fakeNotifications)));
      return;
    }
    if (!hasMore && isLoadMore) {
      emit(NotificationsSuccess(filterNotifications(notifications),
          message: "no_more".tr()));
      return;
    }
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      notifications.clear();
    }
    if (filterNotifications(notifications).isEmpty) {
      emit(NotificationsLoading());
    } else {
      emit(NotificationsSuccess(filterNotifications(notifications),
          isLoadingMore: true));
    }
    try {
      if (isClosed) return;
      final newItems = await notificationsService.getNotifications(
        role,
        locale,
        page: page,
        perPage: perPage,
      );
      lastBatchLength = notifications.length;

      if (newItems.meta.count == newItems.meta.total) {
        hasMore = false;
      }
      if (newItems.data.isEmpty) {
        hasMore = false;
        if (page == 1) {
          emit(NotificationsEmpty("no_notifications".tr()));
        }
      } else {
        notifications.addAll(newItems.data);
        page++;
      }

      if (filterNotifications(notifications).isEmpty) {
        emit(NotificationsEmpty("no_notifications".tr()));
      } else {
        emit(NotificationsSuccess(filterNotifications(notifications)));
      }
    } catch (e) {
      if (isClosed) return;
      if (filterNotifications(notifications).isEmpty) {
        emit(NotificationsFail(e.toString()));
      } else {
        emit(NotificationsSuccess(
          filterNotifications(notifications),
          message: e.toString(),
          isError: true,
        ));
      }
    }
  }

  List<NotificationModel> filterNotifications(
      List<NotificationModel> allNotifications) {
    return allNotifications
        .where((notification) {
          return isReceivedFilter
              ? notification.received
              : !notification.received;
        })
        .toList()
        .where((noti) => isReadFilter ? noti.isRead : !noti.isRead)
        .toList();
  }

  Future<void> addNotification(UserRoleEnum role) async {
    emit(AddNotificationLoading());
    try {
      if (isClosed) return;
      if (scheduleByTime) {
        final t = (addNotificationModel.toJson()['time'] as String?);
        final valid =
            t != null && RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').hasMatch(t);
        if (!valid) {
          throw "time_invalid_format".tr();
        }
      } else {
        addNotificationModel = addNotificationModel.copyWith(
          time: () => null,
          tz: () => null,
        );
      }

      await notificationsService.addNotification(
        role,
        addNotificationModel,
        userIds: userIds,
        image: image,
      );

      emit(AddNotificationSuccess("notification_sent".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AddNotificationFail(e.toString()));
    }
  }

  Future<void> getNotification(UserRoleEnum role, int id) async {
    emit(NotificationLoading());
    try {
      if (isClosed) return;
      final notification = await notificationsService.getNotification(role, id);
      emit(NotificationSuccess(notification));
    } catch (e) {
      if (isClosed) return;
      emit(NotificationFail(e.toString()));
    }
  }

  Future<void> getUnreadNotificationsCount(UserRoleEnum role) async {
    emit(UnreadNotificationsCountLoading());
    try {
      if (isClosed) return;
      final count =
          await notificationsService.getUnreadNotificationsCount(role);
      emit(UnreadNotificationsCountSuccess(count));
    } catch (e) {
      if (isClosed) return;
      emit(UnreadNotificationsCountFail(e.toString()));
    }
  }
}
