import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'assign_subscribers_model.g.dart';

@JsonSerializable()
@immutable
class AssignSubscribersModel {
  const AssignSubscribersModel({
    List<int>? users = const [],
    int? dietitianId,
    int? coachId,
    int? levelId,
    int? doctorId,
    int? psychologistId,
  })  : _users = users,
        _dietitianId = dietitianId,
        _coachId = coachId,
        _levelId = levelId,
        _doctorId = doctorId,
        _psychologistId = psychologistId;

  final List<int>? _users;
  final int? _dietitianId;
  final int? _coachId;
  final int? _levelId;
  final int? _doctorId;
  final int? _psychologistId;

  AssignSubscribersModel copyWith({
    List<int>? Function()? users,
    int? Function()? dietitianId,
    int? Function()? coachId,
    int? Function()? levelId,
    int? Function()? doctorId,
    int? Function()? psychologistId,
  }) {
    return AssignSubscribersModel(
      users: users != null ? users() : _users,
      dietitianId: dietitianId != null ? dietitianId() : _dietitianId,
      coachId: coachId != null ? coachId() : _coachId,
      levelId: levelId != null ? levelId() : _levelId,
      doctorId: doctorId != null ? doctorId() : _doctorId,
      psychologistId:
          psychologistId != null ? psychologistId() : _psychologistId,
    );
  }

  @JsonKey(name: 'user_id')
  List<int> get users {
    if (_users == null || _users.isEmpty) {
      throw "at_least_one_subscriber".tr();
    }
    return _users;
  }

  @JsonKey(name: 'dietitian_id')
  int? get dietitianId {
    return _dietitianId;
  }

  @JsonKey(name: 'coach_id')
  int? get coachId {
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
    return _doctorId;
  }

  @JsonKey(name: 'psychologist_id')
  int? get psychologistId {
    return _psychologistId;
  }

  factory AssignSubscribersModel.fromJson(Map<String, dynamic> json) =>
      _$AssignSubscribersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignSubscribersModelToJson(this);

  factory AssignSubscribersModel.fromString(String jsonString) =>
      AssignSubscribersModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
