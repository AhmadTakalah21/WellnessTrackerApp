import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_medical_consultation_model.g.dart';

@JsonSerializable()
@immutable
class AddMedicalConsultationModel {
  const AddMedicalConsultationModel({
    String? medicalConsultation,
  }) : _medicalConsultation = medicalConsultation;

  final String? _medicalConsultation;

  AddMedicalConsultationModel copyWith({
    String? Function()? medicalConsultation,
  }) {
    return AddMedicalConsultationModel(
      medicalConsultation: medicalConsultation != null
          ? medicalConsultation()
          : _medicalConsultation,
    );
  }

  @JsonKey(name: "medical_consultation")
  String get medicalConsultation {
    if (_medicalConsultation == null) {
      throw "medical_consultation_required".tr();
    }
    return _medicalConsultation;
  }

  factory AddMedicalConsultationModel.fromJson(Map<String, dynamic> json) =>
      _$AddMedicalConsultationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMedicalConsultationModelToJson(this);

  factory AddMedicalConsultationModel.fromString(String jsonString) =>
      AddMedicalConsultationModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
