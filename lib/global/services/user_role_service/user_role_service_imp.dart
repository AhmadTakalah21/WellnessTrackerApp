part of 'user_role_service.dart';

@Injectable(as: UserRoleService)
class UserRoleServiceImp implements UserRoleService {
  final dio = DioClient();

  @override
  Future<List<UserRoleModel>> getUserRoles() async {
    try {
      final response = await dio.get("/roles");
      final roles = response.data["data"] as List<Map<String, dynamic>>;
      return roles.map((role) => UserRoleModel.fromJson(role)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
