// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInfoModel _$AddInfoModelFromJson(Map<String, dynamic> json) => AddInfoModel(
      trainPlace: json['is_in_gym'] == null
          ? HouseOrGymEnum.house
          : HouseOrGymEnum.fromJson((json['is_in_gym'] as num).toInt()),
      gender: GenderEnum.fromJson(json['gender'] as String),
      birthday: json['birthday'] as String?,
      weight: json['weight'] as String?,
      length: json['length'] as String?,
      chronicDiseases: json['chronic_diseases'] as String?,
      waistCircumference: json['waist_circumference'] as String?,
      chest: json['chest'] as String?,
      shoulder: json['shoulder'] as String?,
      thighCircumference: json['thigh_circumference'] as String?,
      forearmCircumference: json['forearm_circumference'] as String?,
      trainProblems: json['train_problems'] as String?,
    );

Map<String, dynamic> _$AddInfoModelToJson(AddInfoModel instance) =>
    <String, dynamic>{
      'is_in_gym': HouseOrGymEnum.toJson(instance.trainPlace),
      'gender': GenderEnum.toJson(instance.gender),
      'birthday': instance.birthday,
      'weight': instance.weight,
      'length': instance.length,
      'chronic_diseases': instance.chronicDiseases,
      'waist_circumference': instance.waistCircumference,
      'chest': instance.chest,
      'shoulder': instance.shoulder,
      'thigh_circumference': instance.thighCircumference,
      'forearm_circumference': instance.forearmCircumference,
      'train_problems': instance.trainProblems,
    };
