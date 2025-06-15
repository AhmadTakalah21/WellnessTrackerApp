import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/user_role_model/user_role_model.dart';

part 'user_role_service_imp.dart';

abstract class UserRoleService {
  Future<List<UserRoleModel>> getUserRoles();
}
