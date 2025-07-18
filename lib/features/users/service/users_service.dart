import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/users/model/add_user_model/add_user_model.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'users_service_imp.dart';

abstract class UserService {
  Future<PaginatedModel<UserModel>> getUsers({int? perPage = 10, int? page});
  Future<UserModel> getUser(int userId);
  Future<UserModel> addUser(AddUserModel adduserModel, {int? userId});
}
