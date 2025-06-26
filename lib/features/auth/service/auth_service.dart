import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/auth/model/post_sign_up_model/post_sign_up_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'auth_service_imp.dart';

abstract class AuthService {
  Future<SignInModel> signIn(String email, String password);
  Future<SignInModel> signUp(PostSignUpModel postSignUpModel);
  Future<void> logout();
}