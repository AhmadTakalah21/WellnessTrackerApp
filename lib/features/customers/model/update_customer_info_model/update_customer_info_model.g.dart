// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerInfoModel _$UpdateCustomerInfoModelFromJson(
        Map<String, dynamic> json) =>
    UpdateCustomerInfoModel(
      trainPlace: json['is_in_gym'] == null
          ? HouseOrGymEnum.house
          : HouseOrGymEnum.fromJson((json['is_in_gym'] as num).toInt()),
      weight: json['weight'] as String?,
      length: json['length'] as String?,
      chronicDiseases: json['chronic_diseases'] as String?,
      waistCircumference: json['waist_circumference'] as String?,
      chest: json['chest'] as String?,
      shoulder: json['shoulder'] as String?,
      trainProblems: json['train_problems'] as String?,
    );

Map<String, dynamic> _$UpdateCustomerInfoModelToJson(
        UpdateCustomerInfoModel instance) =>
    <String, dynamic>{
      'is_in_gym': HouseOrGymEnum.toJson(instance.trainPlace),
      'weight': instance.weight,
      'length': instance.length,
      'chronic_diseases': instance.chronicDiseases,
      'waist_circumference': instance.waistCircumference,
      'chest': instance.chest,
      'shoulder': instance.shoulder,
      'train_problems': instance.trainProblems,
    };
