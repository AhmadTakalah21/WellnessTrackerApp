import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_item_model/ingredient_item_model.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';

part 'add_meal_model.g.dart';

@JsonSerializable()
@immutable
class AddMealModel {
  const AddMealModel({
    String? name,
    String? description,
    MealTypeEnum? type,
    String? link,
    String? file,
    List<IngredientItemModel>? ingredients,
  })  : _name = name,
        _description = description,
        _type = type,
        _link = link,
        _file = file,
        _ingredients = ingredients;

  final String? _name;
  final String? _description;
  final MealTypeEnum? _type;
  final String? _link;
  final String? _file;
  final List<IngredientItemModel>? _ingredients;

  AddMealModel copyWith({
    String? Function()? name,
    String? Function()? description,
    MealTypeEnum? Function()? type,
    String? Function()? link,
    String? Function()? file,
    List<IngredientItemModel>? Function()? ingredients,
  }) {
    return AddMealModel(
      name: name != null ? name() : _name,
      description: description != null ? description() : _description,
      type: type != null ? type() : _type,
      link: link != null ? link() : _link,
      file: file != null ? file() : _file,
      ingredients: ingredients != null ? ingredients() : _ingredients,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  String get description {
    if (_description == null || _description.isEmpty) {
      throw "description_required".tr();
    }
    return _description;
  }

  @JsonKey(
    fromJson: MealTypeEnum.fromJson,
    toJson: MealTypeEnum.toJson,
  )
  MealTypeEnum get type {
    if (_type == null) {
      throw "type_required".tr();
    }
    return _type;
  }

  String? get link {
    return _link;
  }

  @JsonKey(name: "link_file", toJson: Utils.nullableFileToJson)
  String? get file {
    return _file;
  }

  @JsonKey(includeToJson: false)
  List<IngredientItemModel> get ingredients {
    if (_ingredients == null || _ingredients.isEmpty) {
      throw "ingredients_required".tr();
    }
    return _ingredients;
  }

  factory AddMealModel.fromJson(Map<String, dynamic> json) =>
      _$AddMealModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMealModelToJson(this);

  factory AddMealModel.fromString(String jsonString) =>
      AddMealModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
