part of 'users_service.dart';

@Injectable(as: UserService)
class UserServiceImp implements UserService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<UserModel>> getUsers({
    int? perPage = 10,
    int? page,
    String? role,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final roleParam = role != null ? "filter[role]=$role" : "";
      final endpoint =
          "/v1/admin/users/customers?$pageParam&$perPageParam&$roleParam";
      final response = await dio.get(endpoint);

      final users = response.data as Map<String, dynamic>;
      return PaginatedModel.fromJson(
        users,
        (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser(int userId) async {
    try {
      final response = await dio.get("/user/$userId");
      final user = response.data["data"] as Map<String, dynamic>;
      return UserModel.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> addUser(AddUserModel adduserModel, {int? userId}) async {
    try {
      final isAdd = userId == null;
      final endpoint = isAdd ? "/v1/admin/users" : "/v1/admin/users/$userId";
      final response = await dio.postOrPut(
        endpoint,
        isAdd: isAdd,
        data: adduserModel.toJson(),
      );
      final user = response.data["data"] as Map<String, dynamic>;
      return UserModel.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }
}
