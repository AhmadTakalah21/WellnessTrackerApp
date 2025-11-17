import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/home_or_gym_enum.dart';

part 'update_customer_info_model.g.dart';

@JsonSerializable()
@immutable
class UpdateCustomerInfoModel {
  const UpdateCustomerInfoModel({
    this.trainPlace = HouseOrGymEnum.house,
    String? age,
    String? weight,
    String? length,
    String? chronicDiseases,
    String? waistCircumference,
    String? chest,
    String? shoulder,
    String? trainProblems,
    // String? thighCircumference,
    // String? forearmCircumference,
  })  : _weight = weight,
        _length = length,
        _chronicDiseases = chronicDiseases,
        _waistCircumference = waistCircumference,
        _chest = chest,
        _shoulder = shoulder,
        _trainProblems = trainProblems;
  // _thighCircumference = thighCircumference,
  // _forearmCircumference = forearmCircumference;

  final String? _weight;
  final String? _length;
  final String? _chronicDiseases;
  final String? _waistCircumference;
  final String? _chest;
  final String? _shoulder;
  final String? _trainProblems;

  @JsonKey(
    name: "is_in_gym",
    fromJson: HouseOrGymEnum.fromJson,
    toJson: HouseOrGymEnum.toJson,
  )
  final HouseOrGymEnum trainPlace;
  // final String? _thighCircumference;
  // final String? _forearmCircumference;

  UpdateCustomerInfoModel copyWith({
    String? Function()? weight,
    String? Function()? length,
    String? Function()? chronicDiseases,
    String? Function()? waistCircumference,
    String? Function()? chest,
    String? Function()? shoulder,
    String? Function()? trainProblems,
    HouseOrGymEnum? trainPlace,
    // String? Function()? thighCircumference,
    // String? Function()? forearmCircumference,
  }) {
    return UpdateCustomerInfoModel(
      weight: weight != null ? weight() : _weight,
      length: length != null ? length() : _length,
      chronicDiseases:
          chronicDiseases != null ? chronicDiseases() : _chronicDiseases,
      waistCircumference: waistCircumference != null
          ? waistCircumference()
          : _waistCircumference,
      chest: chest != null ? chest() : _chest,
      shoulder: shoulder != null ? shoulder() : _shoulder,
      trainProblems: trainProblems != null ? trainProblems() : _trainProblems,
      trainPlace: trainPlace ?? this.trainPlace,
      // thighCircumference: thighCircumference != null
      //     ? thighCircumference()
      //     : _thighCircumference,
      // forearmCircumference: forearmCircumference != null
      //     ? forearmCircumference()
      //     : _forearmCircumference,
    );
  }

  String get weight {
    if (_weight == null || _weight.isEmpty) {
      throw "weight_required".tr();
    }
    return _weight;
  }

  String get length {
    if (_length == null || _length.isEmpty) {
      throw "length_required".tr();
    }
    return _length;
  }

  @JsonKey(name: "chronic_diseases")
  String? get chronicDiseases {
    // if (_chronicDiseases == null || _chronicDiseases.isEmpty) {
    //   throw "chronic_diseases_required".tr();
    // }
    return _chronicDiseases;
  }

  @JsonKey(name: "waist_circumference")
  String? get waistCircumference {
    // if (_waistCircumference == null || _waistCircumference.isEmpty) {
    //   throw "waist_required".tr();
    // }
    return _waistCircumference;
  }

  String? get chest {
    // if (_chest == null || _chest.isEmpty) {
    //   throw "chest_required".tr();
    // }
    return _chest;
  }

  String? get shoulder {
    // if (_shoulder == null || _shoulder.isEmpty) {
    //   throw "shoulder_required".tr();
    // }
    return _shoulder;
  }

  @JsonKey(name: "train_problems")
  String? get trainProblems {
    // if (_trainProblems == null || _trainProblems.isEmpty) {
    //   throw "train_problems_required".tr();
    // }
    return _trainProblems;
  }

  // @JsonKey(name: "thigh_circumference")
  // String get thighCircumference {
  //   if (_thighCircumference == null || _thighCircumference.isEmpty) {
  //     throw "thigh_required".tr();
  //   }
  //   return _thighCircumference;
  // }

  // @JsonKey(name: "forearm_circumference")
  // String get forearmCircumference {
  //   if (_forearmCircumference == null || _forearmCircumference.isEmpty) {
  //     throw "forearm_required".tr();
  //   }
  //   return _forearmCircumference;
  // }

  factory UpdateCustomerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCustomerInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCustomerInfoModelToJson(this);

  factory UpdateCustomerInfoModel.fromString(String jsonString) =>
      UpdateCustomerInfoModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
