import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/add_notification_model/add_notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/service/notifications_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/general_notifications_state.dart';
part 'states/notifications_state.dart';
part 'states/add_notification_state.dart';

@injectable
class NotificationsCubit extends Cubit<GeneralNotificationsState> {
  NotificationsCubit(this.notificationsService)
      : super(GeneralNotificationsInitial());

  final NotificationsService notificationsService;

  List<NotificationModel> notifications = [];
  int page = 1;
  bool hasMore = true;

  MetaModel? meta;
  AddNotificationModel addNotificationModel = const AddNotificationModel();
  List<CustomerModel> userIds = [];
  XFile? image;

  bool scheduleByTime = false;

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
    UserRoleEnum role, {
    int perPage = 10,
    bool isLoadMore = true,
  }) async {
    if (!hasMore && isLoadMore) {
      emit(NotificationsSuccess(notifications, hasMore: false));
      return;
    }
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      notifications.clear();
    }
    if (notifications.isEmpty) {
      emit(NotificationsLoading());
    } else {
      emit(NotificationsSuccess(notifications, isLoadingMore: true));
    }
    try {
      if (isClosed) return;
      final newItems = await notificationsService.getNotifications(
        role,
        page: page,
        perPage: perPage,
      );
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

      if (notifications.isEmpty) {
        emit(NotificationsEmpty("no_notifications".tr()));
      } else {
        emit(NotificationsSuccess(notifications));
      }
    } catch (e) {
      if (isClosed) return;
      emit(NotificationsFail(e.toString()));
    }
  }

  Future<void> addNotification(UserRoleEnum role) async {
    emit(AddNotificationLoading());
    try {
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
      emit(AddNotificationFail(e.toString()));
    }
  }
}
