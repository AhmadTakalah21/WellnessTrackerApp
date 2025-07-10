import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'assign_subscriber_model.g.dart';

@JsonSerializable()
@immutable
class AssignSubscriberModel {
  const AssignSubscriberModel({
    int? userId,
    int? dietitianId,
    int? coachId,
    int? levelId,
    int? doctorId,
  })  : _userId = userId,
        _dietitianId = dietitianId,
        _coachId = coachId,
        _levelId = levelId,
        _doctorId = doctorId;

  final int? _userId;
  final int? _dietitianId;
  final int? _coachId;
  final int? _levelId;
  final int? _doctorId;

  AssignSubscriberModel copyWith({
    int? Function()? userId,
    int? Function()? dietitianId,
    int? Function()? coachId,
    int? Function()? levelId,
    int? Function()? doctorId,
  }) {
    return AssignSubscriberModel(
      userId: userId != null ? userId() : _userId,
      dietitianId: dietitianId != null ? dietitianId() : _dietitianId,
      coachId: coachId != null ? coachId() : _coachId,
      levelId: levelId != null ? levelId() : _levelId,
      doctorId: doctorId != null ? doctorId() : _doctorId,
    );
  }

  @JsonKey(name: 'user_id')
  int get userId {
    if (_userId == null) {
      throw "user_required".tr();
    }
    return _userId;
  }

  @JsonKey(name: 'dietitian_id')
  int? get dietitianId {
    // if (_dietitianId == null) {
    //   throw "dietitian_required".tr();
    // }
    return _dietitianId;
  }

  @JsonKey(name: 'coach_id')
  int? get coachId {
    // if (_coachId == null) {
    //   throw "coach_required".tr();
    // }
    return _coachId;
  }

   @JsonKey(name: 'level_id')
  int get levelId {
    if (_levelId == null) {
      throw "level_required".tr();
    }
    return _levelId;
  }

  @JsonKey(name: 'doctor_id')
  int? get doctorId {
    // if (_doctorId == null) {
    //   throw "doctor_required".tr();
    // }
    return _doctorId;
  }

  factory AssignSubscriberModel.fromJson(Map<String, dynamic> json) =>
      _$AssignSubscriberModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignSubscriberModelToJson(this);

  factory AssignSubscriberModel.fromString(String jsonString) =>
      AssignSubscriberModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
