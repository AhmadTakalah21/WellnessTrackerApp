import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/ratings/model/add_rate_model/add_rate_model.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'profile_service_imp.dart';

abstract class ProfileService {
  Future<RatingModel> addRating(AddRateModel addRateModel, {int? id});
  Future<CustomerModel> getProfile();
}
