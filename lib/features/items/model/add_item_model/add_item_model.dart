import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_item_model.g.dart';

@JsonSerializable()
@immutable
class AddItemModel {
  const AddItemModel({
    String? nameAr,
    String? nameEn,
    String? price,
    String? descriptionEn,
    String? descriptionAr,
  })  : _nameAr = nameAr,
        _nameEn = nameEn,
        _price = price,
        _descriptionEn = descriptionEn,
        _descriptionAr = descriptionAr;

  @JsonKey(name: 'name_ar')
  final String? _nameAr;

  @JsonKey(name: 'name_en')
  final String? _nameEn;

  final String? _price;

  @JsonKey(name: 'description_en')
  final String? _descriptionEn;

  @JsonKey(name: 'description_ar')
  final String? _descriptionAr;

  AddItemModel copyWith({
    String? Function()? nameAr,
    String? Function()? nameEn,
    String? Function()? price,
    String? Function()? descriptionEn,
    String? Function()? descriptionAr,
  }) {
    return AddItemModel(
      nameAr: nameAr != null ? nameAr() : _nameAr,
      nameEn: nameEn != null ? nameEn() : _nameEn,
      price: price != null ? price() : _price,
      descriptionEn: descriptionEn != null ? descriptionEn() : _descriptionEn,
      descriptionAr: descriptionAr != null ? descriptionAr() : _descriptionAr,
    );
  }

  String get nameAr {
    if (_nameAr == null || _nameAr.isEmpty) {
      throw "name_ar_required".tr();
    }
    return _nameAr;
  }

  String get nameEn {
    if (_nameEn == null || _nameEn.isEmpty) {
      throw "name_en_required".tr();
    }
    return _nameEn;
  }

  String get price {
    if (_price == null || _price.isEmpty) {
      throw "price_required".tr();
    }
    return _price;
  }

  String get descriptionEn {
    if (_descriptionEn == null || _descriptionEn.isEmpty) {
      throw "description_en_required".tr();
    }
    return _descriptionEn;
  }

  String get descriptionAr {
    if (_descriptionAr == null || _descriptionAr.isEmpty) {
      throw "description_ar_required".tr();
    }
    return _descriptionAr;
  }

  factory AddItemModel.fromJson(Map<String, dynamic> json) =>
      _$AddItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemModelToJson(this);

  factory AddItemModel.fromString(String jsonString) =>
      AddItemModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
