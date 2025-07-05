part of 'user_role_service.dart';

@Injectable(as: UserRoleService)
class UserRoleServiceImp implements UserRoleService {
  final dio = DioClient();

  @override
  Future<List<UserRoleModel>> getUserRoles() async {
    try {
      final response = await dio.get("/v1/admin/roles");
      final data = response.data["data"] as List<dynamic>;
      final roles = data.map((e) => UserRoleModel.fromJson(Map<String, dynamic>.from(e))).toList();
      return roles;
    } catch (e) {
      rethrow;
    }
  }
}

