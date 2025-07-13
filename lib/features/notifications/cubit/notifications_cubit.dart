import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/notifications/model/add_notification_model/add_notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/model/notification_model/notification_model.dart';
import 'package:wellnesstrackerapp/features/notifications/service/notifications_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

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
  XFile? image;

  void setCustomerId(int? customerId) {
    addNotificationModel =
        addNotificationModel.copyWith(customerId: () => customerId);
  }

  void setTitle(String? title) {
    addNotificationModel = addNotificationModel.copyWith(title: () => title);
  }

  void setBody(String? body) {
    addNotificationModel = addNotificationModel.copyWith(body: () => body);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetAddNotificationModel() {
    addNotificationModel = const AddNotificationModel();
  }

  Future<void> getNotifications({int? perPage = 10, int? page}) async {
    emit(NotificationsLoading());
    try {
      if(isClosed) return;
      final result = await notificationsService.getNotifications(
        page: page,
        perPage: perPage,
      );
      notifications = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_notifications".tr() : null;
      emit(NotificationsSuccess(result, message));
    } catch (e) {
      if(isClosed) return;
      emit(NotificationsFail(e.toString()));
    }
  }

  Future<void> addNotification() async {
    emit(AddNotificationLoading());
    try {
      final response =
          await notificationsService.addNotification(addNotificationModel);
      final message = "notification_sent".tr();
      emit(AddNotificationSuccess(response, message));
    } catch (e) {
      emit(AddNotificationFail(e.toString()));
    }
  }
}
