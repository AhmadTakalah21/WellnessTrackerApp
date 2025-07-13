import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';

part 'add_level_model.g.dart';

@JsonSerializable()
@immutable
class AddLevelModel {
  const AddLevelModel({
    String? name,
    DepartmentEnum? type,
    String? description,
  })  : _name = name,
        _type = type,
        _description = description;

  final String? _name;
  final DepartmentEnum? _type;
  final String? _description;

  AddLevelModel copyWith({
    String? Function()? name,
    DepartmentEnum? Function()? type,
    String? Function()? description,
  }) {
    return AddLevelModel(
      name: name != null ? name() : _name,
      type: type != null ? type() : _type,
      description: description != null ? description() : _description,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  @JsonKey(
    fromJson: DepartmentEnum.fromJson,
    toJson: DepartmentEnum.toJson,
  )
  DepartmentEnum get type {
    if (_type == null) {
      throw "type_required".tr();
    }
    return _type;
  }

  String? get description => _description;

  factory AddLevelModel.fromJson(Map<String, dynamic> json) =>
      _$AddLevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddLevelModelToJson(this);

  factory AddLevelModel.fromString(String jsonString) =>
      AddLevelModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
