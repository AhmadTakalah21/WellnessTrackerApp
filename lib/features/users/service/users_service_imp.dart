part of 'users_service.dart';

@Injectable(as: UserService)
class UserServiceImp implements UserService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<UserModel>> getUsers({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final response = await dio.get("/user?$pageParam&$perPageParam");
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
  Future<UserModel> addUser(
    AddUserModel adduserModel, {
    required bool isAdd,
    int? userId,
  }) async {
    try {
      final endpoint = isAdd ? "/user" : "/user/$userId";
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
