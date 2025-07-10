import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_item_model.g.dart';

@JsonSerializable()
@immutable
class AddItemModel {
  const AddItemModel({
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? link,
    String? price,
    int? levelId,
  })  : _nameEn = nameEn,
        _nameAr = nameAr,
        _descriptionEn = descriptionEn,
        _descriptionAr = descriptionAr,
        _link = link,
        _price = price,
        _levelId = levelId;

  final String? _nameEn;
  final String? _nameAr;
  final String? _descriptionEn;
  final String? _descriptionAr;
  final String? _link;
  final String? _price;
  final int? _levelId;

  AddItemModel copyWith({
    String? Function()? nameEn,
    String? Function()? nameAr,
    String? Function()? descriptionEn,
    String? Function()? descriptionAr,
    String? Function()? link,
    String? Function()? price,
    int? Function()? levelId,
  }) {
    return AddItemModel(
      nameEn: nameEn != null ? nameEn() : _nameEn,
      nameAr: nameAr != null ? nameAr() : _nameAr,
      descriptionEn: descriptionEn != null ? descriptionEn() : _descriptionEn,
      descriptionAr: descriptionAr != null ? descriptionAr() : _descriptionAr,
      link: link != null ? link() : _link,
      price: price != null ? price() : _price,
      levelId: levelId != null ? levelId() : _levelId,
    );
  }

  @JsonKey(name: 'name[en]')
  String get nameEn {
    if (_nameEn == null || _nameEn.isEmpty) {
      throw "name_en_required".tr();
    }
    return _nameEn;
  }

  @JsonKey(name: 'name[ar]')
  String get nameAr {
    if (_nameAr == null || _nameAr.isEmpty) {
      throw "name_ar_required".tr();
    }
    return _nameAr;
  }

  @JsonKey(name: 'description[en]')
  String? get descriptionEn => _descriptionEn;

  @JsonKey(name: 'description[ar]')
  String? get descriptionAr => _descriptionAr;

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
