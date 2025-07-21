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
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
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
  MetaModel? meta;
  AddNotificationModel addNotificationModel = const AddNotificationModel();
  List<CustomerModel> userIds = [];
  XFile? image;

  void setIsAll(String? isAll) {
    addNotificationModel = addNotificationModel.copyWith(isAll: isAll);
  }

  void setUsers(List<CustomerModel> userIds) {
    print(userIds);
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

  void resetAddNotificationModel() {
    addNotificationModel = const AddNotificationModel();
  }

  Future<void> getNotifications(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    emit(NotificationsLoading());
    try {
      if (isClosed) return;
      final result = await notificationsService.getNotifications(
        role,
        page: page,
        perPage: perPage,
      );
      notifications = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_notifications".tr() : null;
      if (result.data.isEmpty && result.meta.currentPage == 1) {
        emit(NotificationsEmpty("no_notifications".tr()));
      } else {
        emit(NotificationsSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(NotificationsFail(e.toString()));
    }
  }

  Future<void> addNotification() async {
    emit(AddNotificationLoading());
    try {
      final response = await notificationsService.addNotification(
        addNotificationModel,
        userIds: userIds,
        image: image,
      );
      final message = "notification_sent".tr();
      emit(AddNotificationSuccess(response, message));
    } catch (e) {
      emit(AddNotificationFail(e.toString()));
    }
  }
}
