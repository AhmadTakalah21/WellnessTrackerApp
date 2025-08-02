import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_exercise_description_model.g.dart';

@JsonSerializable()
@immutable
class AddExerciseDescriptionModel {
  const AddExerciseDescriptionModel({
    int? rounds,
    String? explain,
    List<int>? repeats,
  })  : _rounds = rounds,
        _explain = explain,
        _repeats = repeats;

  final int? _rounds;
  final String? _explain;
  final List<int>? _repeats;

  AddExerciseDescriptionModel copyWith({
    int? Function()? rounds,
    String? Function()? explain,
    List<int>? Function()? repeats,
  }) {
    return AddExerciseDescriptionModel(
      rounds: rounds != null ? rounds() : _rounds,
      explain: explain != null ? explain() : _explain,
      repeats: repeats != null ? repeats() : _repeats,
    );
  }

  int get rounds {
    if (_rounds == null || _rounds == 0) {
      throw "rounds_required".tr();
    }
    return _rounds;
  }

  String get explain {
    if (_explain == null || _explain.isEmpty) {
      throw "explain_required".tr();
    }
    return _explain;
  }

  List<int> get repeats {
    if (_repeats == null ||
        _repeats.isEmpty ||
        _repeats.any((repeat) => repeat == 0)) {
      throw "repeats_required".tr();
    }
    return _repeats;
  }

  factory AddExerciseDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$AddExerciseDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddExerciseDescriptionModelToJson(this);

  factory AddExerciseDescriptionModel.fromString(String str) =>
      AddExerciseDescriptionModel.fromJson(json.decode(str));

  @override
  String toString() => jsonEncode(toJson());
}
