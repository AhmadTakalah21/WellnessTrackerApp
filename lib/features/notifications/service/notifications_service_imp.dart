part of 'notifications_service.dart';

@Injectable(as: NotificationsService)
class NotificationsServiceImp implements NotificationsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<NotificationModel>> getNotifications({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/admin/notifications?$pageParam&$perPageParam";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => NotificationModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<NotificationModel> addNotification(AddNotificationModel model) async {
    final endpoint = "/v1/admin/notifications";

    try {
      final response = await dio.post(endpoint, data: model.toJson());
      final data = response.data["data"] as Map<String, dynamic>;
      return NotificationModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
