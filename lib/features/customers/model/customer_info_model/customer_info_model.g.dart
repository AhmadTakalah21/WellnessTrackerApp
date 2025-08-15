// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInfoModel _$CustomerInfoModelFromJson(Map<String, dynamic> json) =>
    CustomerInfoModel(
      id: (json['id'] as num).toInt(),
      age: (json['age'] as num?)?.toInt(),
      weight: (json['weight'] as num).toInt(),
      length: (json['length'] as num).toInt(),
      chronicDiseases: json['chronic_diseases'] as String?,
      waistCircumference: (json['waist_circumference'] as num?)?.toInt(),
      chest: (json['chest'] as num?)?.toInt(),
      shoulder: (json['shoulder'] as num?)?.toInt(),
      thighCircumference: (json['thigh_circumference'] as num?)?.toInt(),
      forearmCircumference: (json['forearm_circumference'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$CustomerInfoModelToJson(CustomerInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'age': instance.age,
      'weight': instance.weight,
      'length': instance.length,
      'chronic_diseases': instance.chronicDiseases,
      'waist_circumference': instance.waistCircumference,
      'chest': instance.chest,
      'shoulder': instance.shoulder,
      'thigh_circumference': instance.thighCircumference,
      'forearm_circumference': instance.forearmCircumference,
      'created_at': instance.createdAt,
    };
