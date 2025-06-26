part of 'auth_service.dart';

@Injectable(as: AuthService)
class AuthServiceImp implements AuthService {
  final dio = DioClient();

  @override
  Future<SignInModel> signIn(String email, String password) async {
    try {
      final data = {'email': email, 'password': password};
      final response = await dio.post('/login', data: data);

      final body = response.data["data"] as Map<String, dynamic>;
      return SignInModel.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignInModel> signUp(PostSignUpModel postSignUpModel) async {
    try {
      final data = postSignUpModel.toJson();
      final response = await dio.post('/v1/users', data: data);

      final body = response.data["data"] as Map<String, dynamic>;
      return SignInModel.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/logout');
    } catch (e) {
      rethrow;
    }
  }
}
