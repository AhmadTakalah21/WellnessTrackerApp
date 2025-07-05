// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvModel _$AdvModelFromJson(Map<String, dynamic> json) => AdvModel(
      id: (json['id'] as num).toInt(),
      address: json['address'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      expDate: json['exp_date'] as String,
      type: AdvTypeEnum.fromJson((json['type'] as num).toInt()),
      isActive: const BoolConverter().fromJson(json['is_active']),
    );

Map<String, dynamic> _$AdvModelToJson(AdvModel instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'description': instance.description,
      'image': instance.image,
      'exp_date': instance.expDate,
      'type': AdvTypeEnum.toJson(instance.type),
      'is_active': const BoolConverter().toJson(instance.isActive),
    };
