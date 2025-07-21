import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';

part 'add_ingredient_model.g.dart';

@JsonSerializable()
@immutable
class AddIngredientModel {
  const AddIngredientModel({
    String? name,
    IngredientUnitEnum? unit,
    String? calories,
    String? carbs,
    String? proteins,
  })  : _name = name,
        _unit = unit,
        _calories = calories,
        _carbs = carbs,
        _proteins = proteins;

  final String? _name;
  final IngredientUnitEnum? _unit;
  final String? _calories;
  final String? _carbs;
  final String? _proteins;

  AddIngredientModel copyWith({
    String? Function()? name,
    IngredientUnitEnum? Function()? unit,
    String? Function()? calories,
    String? Function()? carbs,
    String? Function()? proteins,
  }) {
    return AddIngredientModel(
      name: name != null ? name() : _name,
      unit: unit != null ? unit() : _unit,
      calories: calories != null ? calories() : _calories,
      carbs: carbs != null ? carbs() : _carbs,
      proteins: proteins != null ? proteins() : _proteins,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  @JsonKey(
    fromJson: IngredientUnitEnum.fromJson,
    toJson: IngredientUnitEnum.toJson,
  )
  IngredientUnitEnum get unit {
    if (_unit == null) {
      throw "unit_required".tr();
    }
    return _unit;
  }

  String get calories {
    if (_calories == null || _calories.isEmpty) {
      throw "calories_required".tr();
    }
    return _calories;
  }

  String get carbs {
    if (_carbs == null || _carbs.isEmpty) {
      throw "carbs_required".tr();
    }
    return _carbs;
  }

  String get proteins {
    if (_proteins == null || _proteins.isEmpty) {
      throw "proteins_required".tr();
    }
    return _proteins;
  }

  factory AddIngredientModel.fromJson(Map<String, dynamic> json) =>
      _$AddIngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddIngredientModelToJson(this);

  factory AddIngredientModel.fromString(String jsonString) =>
      AddIngredientModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
