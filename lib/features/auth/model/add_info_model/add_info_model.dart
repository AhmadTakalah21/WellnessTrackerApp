import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';

part 'add_info_model.g.dart';

@JsonSerializable()
@immutable
class AddInfoModel {
  const AddInfoModel({
    GenderEnum? gender,
    String? birthday,
    String? age,
    String? weight,
    String? length,
    String? chronicDiseases,
    String? waistCircumference,
    String? chest,
    String? shoulder,
    String? thighCircumference,
    String? forearmCircumference,
  })  : _gender = gender,
        _birthday = birthday,
        _age = age,
        _weight = weight,
        _length = length,
        _chronicDiseases = chronicDiseases,
        _waistCircumference = waistCircumference,
        _chest = chest,
        _shoulder = shoulder,
        _thighCircumference = thighCircumference,
        _forearmCircumference = forearmCircumference;

  final GenderEnum? _gender;
  final String? _birthday;
  final String? _age;
  final String? _weight;
  final String? _length;
  final String? _chronicDiseases;
  final String? _waistCircumference;
  final String? _chest;
  final String? _shoulder;
  final String? _thighCircumference;
  final String? _forearmCircumference;

  AddInfoModel copyWith({
    GenderEnum? Function()? gender,
    String? Function()? birthday,
    String? Function()? age,
    String? Function()? weight,
    String? Function()? length,
    String? Function()? chronicDiseases,
    String? Function()? waistCircumference,
    String? Function()? chest,
    String? Function()? shoulder,
    String? Function()? thighCircumference,
    String? Function()? forearmCircumference,
  }) {
    return AddInfoModel(
      gender: gender != null ? gender() : _gender,
      birthday: birthday != null ? birthday() : _birthday,
      age: age != null ? age() : _age,
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

  String get age {
    if (_age == null || _age.isEmpty) {
      throw "age_required".tr();
    }
    return _age;
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
  String get chronicDiseases {
    if (_chronicDiseases == null || _chronicDiseases.isEmpty) {
      throw "chronic_diseases_required".tr();
    }
    return _chronicDiseases;
  }

  @JsonKey(name: "waist_circumference")
  String get waistCircumference {
    if (_waistCircumference == null || _waistCircumference.isEmpty) {
      throw "waist_required".tr();
    }
    return _waistCircumference;
  }

  String get chest {
    if (_chest == null || _chest.isEmpty) {
      throw "chest_required".tr();
    }
    return _chest;
  }

  String get shoulder {
    if (_shoulder == null || _shoulder.isEmpty) {
      throw "shoulder_required".tr();
    }
    return _shoulder;
  }

  @JsonKey(name: "thigh_circumference")
  String get thighCircumference {
    if (_thighCircumference == null || _thighCircumference.isEmpty) {
      throw "thigh_required".tr();
    }
    return _thighCircumference;
  }

  @JsonKey(name: "forearm_circumference")
  String get forearmCircumference {
    if (_forearmCircumference == null || _forearmCircumference.isEmpty) {
      throw "forearm_required".tr();
    }
    return _forearmCircumference;
  }

  factory AddInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AddInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddInfoModelToJson(this);

  factory AddInfoModel.fromString(String jsonString) =>
      AddInfoModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
