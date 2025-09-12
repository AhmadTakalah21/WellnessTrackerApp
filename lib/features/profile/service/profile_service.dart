import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/profile/model/update_profile_model/update_profile_model.dart';
import 'package:wellnesstrackerapp/features/ratings/model/add_rate_model/add_rate_model.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'profile_service_imp.dart';

abstract class ProfileService {
  Future<RatingModel> addRating(AddRateModel addRateModel, {int? id});
  Future<CustomerModel> getProfile();
  Future<CustomerModel> updateProfile(UpdateProfileModel model, {XFile? image});
}
