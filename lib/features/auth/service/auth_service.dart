import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/auth/model/add_info_model/add_info_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/post_sign_up_model/post_sign_up_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'auth_service_imp.dart';

abstract class AuthService {
  Future<SignInModel> signIn(String email, String password, String? fcmToken,
      {String? code});
  Future<SignInModel> signUp(PostSignUpModel postSignUpModel);
  Future<CustomerModel> addInfo(AddInfoModel addInfoModel);
  Future<void> logout();
}
