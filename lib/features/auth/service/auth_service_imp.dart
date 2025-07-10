part of 'auth_service.dart';

@Injectable(as: AuthService)
class AuthServiceImp implements AuthService {
  final dio = DioClient();

  @override
  Future<SignInModel> signIn(
    String email,
    String password,
    String? fcmToken,
  ) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };
      final response = await dio.post('/v1/auth/login', data: data);

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
      final response = await dio.post('/v1/auth/register', data: data);

      final body = response.data["data"] as Map<String, dynamic>;
      return SignInModel.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CustomerModel> addInfo(AddInfoModel addInfoModel) async {
    final endpoint = "/v1/users/information";
    try {
      final data = addInfoModel.toJson();
      final response = await dio.post(endpoint, data: data);
      final customer = response.data["data"] as Map<String, dynamic>;
      return CustomerModel.fromJson(customer);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/v1/auth/logout');
    } catch (e) {
      rethrow;
    }
  }
}
