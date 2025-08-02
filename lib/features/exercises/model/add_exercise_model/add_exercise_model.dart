import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercises/model/add_exercise_description_model/add_exercise_description_model.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';

part 'add_exercise_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AddExerciseModel {
  const AddExerciseModel({
    String? name,
    String? link,
    String? file,
    AddExerciseDescriptionModel? description,
  })  : _name = name,
        _link = link,
        _file = file,
        _description = description;

  final String? _name;
  final String? _link;
  final String? _file;
  final AddExerciseDescriptionModel? _description;

  AddExerciseModel copyWith({
    String? Function()? name,
    String? Function()? link,
    String? Function()? file,
    AddExerciseDescriptionModel? Function()? description,
  }) {
    return AddExerciseModel(
      name: name != null ? name() : _name,
      link: link != null ? link() : _link,
      file: file != null ? file() : _file,
      description: description != null ? description() : _description,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  String? get link {
    return _link;
  }

  @JsonKey(name: "link_file", toJson: Utils.nullableFileToJson)
  String? get file {
    return _file;
  }

  AddExerciseDescriptionModel get description {
    if (_description == null) {
      throw "description_required".tr();
    }
    return _description;
  }

  factory AddExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$AddExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddExerciseModelToJson(this);

  factory AddExerciseModel.fromString(String jsonStr) =>
      AddExerciseModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());
}
