part of 'notifications_service.dart';

@Injectable(as: NotificationsService)
class NotificationsServiceImp implements NotificationsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<NotificationModel>> getNotifications(
    UserRoleEnum role,
    Locale locale, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final headers = {"Accept-Language": locale.languageCode};
      final queries = {
        if (perPage != null) "per_page": perPage,
        if (page != null) "page": page,
      };
      final endpoint = "/v1/${role.getApiRoute}/notifications";
      final response =
          await dio.get(endpoint, headers: headers, queries: queries);

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
  Future<void> addNotification(
    UserRoleEnum role,
    AddNotificationModel model, {
    required List<CustomerModel> userIds,
    XFile? image,
  }) async {
    final endpoint = "/v1/${role.getApiRoute}/notifications/send";

    try {
      final map = model.toJson();
      if (userIds.isNotEmpty) {
        for (var index = 0; index < userIds.length; index++) {
          map.addAll({"userIds[$index]": userIds[index].id});
        }
      }
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);

      await dio.post(endpoint, data: formData);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<NotificationModel> getNotification(UserRoleEnum role, int id) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/notifications/$id";
      final response = await dio.get(endpoint);
      final data = response.data["data"] as Map<String, dynamic>;

      return NotificationModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print("stackTrace of getNotification $id: $stackTrace");
      rethrow;
    }
  }

  @override
  Future<int> getUnreadNotificationsCount(UserRoleEnum role) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/notifications/num-of-not-read";
      final response = await dio.get(endpoint);
      final data = response.data["data"] as Map<String, dynamic>;
      return data["num_of_not_read"] as int;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("stackTrace of getUnreadNotificationsCount $stackTrace");
      }
      rethrow;
    }
  }
}
