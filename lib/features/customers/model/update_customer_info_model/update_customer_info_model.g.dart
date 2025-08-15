// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerInfoModel _$UpdateCustomerInfoModelFromJson(
        Map<String, dynamic> json) =>
    UpdateCustomerInfoModel(
      weight: json['weight'] as String?,
      length: json['length'] as String?,
      chronicDiseases: json['chronic_diseases'] as String?,
      waistCircumference: json['waist_circumference'] as String?,
      chest: json['chest'] as String?,
      shoulder: json['shoulder'] as String?,
    );

Map<String, dynamic> _$UpdateCustomerInfoModelToJson(
        UpdateCustomerInfoModel instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'length': instance.length,
      'chronic_diseases': instance.chronicDiseases,
      'waist_circumference': instance.waistCircumference,
      'chest': instance.chest,
      'shoulder': instance.shoulder,
    };
