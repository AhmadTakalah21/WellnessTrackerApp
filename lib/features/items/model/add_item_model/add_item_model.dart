import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';

part 'add_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AddItemModel {
  const AddItemModel({
    EnArAddModel? name,
    EnArAddModel? description,
    String? link,
    String? price,
    int? levelId,
  })  : _name = name,
        _description = description,
        _link = link,
        _price = price,
        _levelId = levelId;

  final EnArAddModel? _name;
  final EnArAddModel? _description;
  final String? _link;
  final String? _price;
  final int? _levelId;

  AddItemModel copyWith({
    EnArAddModel? Function()? name,
    EnArAddModel? Function()? description,
    String? Function()? link,
    String? Function()? price,
    int? Function()? levelId,
  }) {
    return AddItemModel(
      name: name != null ? name() : _name,
      description: description != null ? description() : _description,
      link: link != null ? link() : _link,
      price: price != null ? price() : _price,
      levelId: levelId != null ? levelId() : _levelId,
    );
  }

  EnArAddModel get name {
    if (_name == null) {
      throw "name_en_required".tr();
    }
    return _name;
  }

  EnArAddModel? get description => _description;

  @JsonKey(name: 'link')
  String? get link => _link;

  @JsonKey(name: 'price')
  String get price {
    if (_price == null || _price.isEmpty) {
      throw "price_required".tr();
    }
    return _price;
  }

  @JsonKey(name: 'level_id')
  int get levelId {
    if (_levelId == null) {
      throw "level_required".tr();
    }
    return _levelId;
  }

  factory AddItemModel.fromJson(Map<String, dynamic> json) =>
      _$AddItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemModelToJson(this);

  factory AddItemModel.fromString(String jsonString) =>
      AddItemModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
