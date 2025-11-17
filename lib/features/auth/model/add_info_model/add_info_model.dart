import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/models/home_or_gym_enum.dart';

part 'add_info_model.g.dart';

@JsonSerializable()
@immutable
class AddInfoModel {
  const AddInfoModel({
    this.trainPlace = HouseOrGymEnum.house,
    GenderEnum? gender,
    String? birthday,
    String? weight,
    String? length,
    String? chronicDiseases,
    String? waistCircumference,
    String? chest,
    String? shoulder,
    String? thighCircumference,
    String? forearmCircumference,
    String? trainProblems,
  })  : _gender = gender,
        _birthday = birthday,
        _weight = weight,
        _length = length,
        _chronicDiseases = chronicDiseases,
        _waistCircumference = waistCircumference,
        _chest = chest,
        _shoulder = shoulder,
        _thighCircumference = thighCircumference,
        _forearmCircumference = forearmCircumference,
        _trainProblems = trainProblems;

  final GenderEnum? _gender;
  final String? _birthday;
  final String? _weight;
  final String? _length;
  final String? _chronicDiseases;
  final String? _waistCircumference;
  final String? _chest;
  final String? _shoulder;
  final String? _thighCircumference;
  final String? _forearmCircumference;
  final String? _trainProblems;

  @JsonKey(
    name: "is_in_gym",
    fromJson: HouseOrGymEnum.fromJson,
    toJson: HouseOrGymEnum.toJson,
  )
  final HouseOrGymEnum trainPlace;

  AddInfoModel copyWith({
    GenderEnum? Function()? gender,
    String? Function()? birthday,
    String? Function()? weight,
    String? Function()? length,
    String? Function()? chronicDiseases,
    String? Function()? waistCircumference,
    String? Function()? chest,
    String? Function()? shoulder,
    String? Function()? thighCircumference,
    String? Function()? forearmCircumference,
    String? Function()? trainProblems,
    HouseOrGymEnum? trainPlace,
  }) {
    return AddInfoModel(
      gender: gender != null ? gender() : _gender,
      birthday: birthday != null ? birthday() : _birthday,
      weight: weight != null ? weight() : _weight,
      length: length != null ? length() : _length,
      chronicDiseases:
          chronicDiseases != null ? chronicDiseases() : _chronicDiseases,
      waistCircumference: waistCircumference != null
          ? waistCircumference()
          : _waistCircumference,
      chest: chest != null ? chest() : _chest,
      shoulder: shoulder != null ? shoulder() : _shoulder,
      thighCircumference: thighCircumference != null
          ? thighCircumference()
          : _thighCircumference,
      forearmCircumference: forearmCircumference != null
          ? forearmCircumference()
          : _forearmCircumference,
      trainProblems: trainProblems != null ? trainProblems() : _trainProblems,
      trainPlace: trainPlace ?? this.trainPlace,
    );
  }

  @JsonKey(fromJson: GenderEnum.fromJson, toJson: GenderEnum.toJson)
  GenderEnum get gender {
    if (_gender == null) {
      throw "gender_required".tr();
    }
    return _gender;
  }

  String get birthday {
    if (_birthday == null || _birthday.isEmpty) {
      throw "birthday_required".tr();
    }
    return _birthday;
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

  @JsonKey(name: "thigh_circumference")
  String? get thighCircumference {
    // if (_thighCircumference == null || _thighCircumference.isEmpty) {
    //   throw "thigh_required".tr();
    // }
    return _thighCircumference;
  }

  @JsonKey(name: "forearm_circumference")
  String? get forearmCircumference {
    // if (_forearmCircumference == null || _forearmCircumference.isEmpty) {
    //   throw "forearm_required".tr();
    // }
    return _forearmCircumference;
  }

  @JsonKey(name: "train_problems")
  String? get trainProblems {
    // if (_trainProblems == null || _trainProblems.isEmpty) {
    //   throw "train_problems_required".tr();
    // }
    return _trainProblems;
  }

  factory AddInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AddInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddInfoModelToJson(this);

  factory AddInfoModel.fromString(String jsonString) =>
      AddInfoModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
