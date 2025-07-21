part of 'notifications_service.dart';

@Injectable(as: NotificationsService)
class NotificationsServiceImp implements NotificationsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<NotificationModel>> getNotifications(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint =
          "/v1/${role.getApiRoute}/notifications?$pageParam&$perPageParam";
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
  Future<NotificationModel> addNotification(
    AddNotificationModel model, {
    required List<CustomerModel> userIds,
    XFile? image,
  }) async {
    final endpoint = "/v1/admin/notifications";

    try {
      final map = model.toJson();
      if (userIds.isNotEmpty) {
        for (var index = 0; index < userIds.length; index++) {
          final id = userIds[index].id;
          map.addAll({"userIds[$index]": id});
        }
      }
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);

      final response = await dio.post(endpoint, data: formData);
      final data = response.data["data"] as Map<String, dynamic>;
      return NotificationModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
