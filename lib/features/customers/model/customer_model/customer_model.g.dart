// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      age: (json['age'] as num?)?.toInt(),
      email: json['email'] as String,
      phone: json['phone'] as String?,
      gender: GenderEnum.nullableFromJson(json['gender'] as String?),
      birthday: json['birthday'] as String?,
      status: json['status'] as String,
      image: JsonUtils.setImageUrlNullableFromJson(
          JsonUtils.readValue(json, 'image') as Map<String, dynamic>),
      role: UserRoleEnum.fromJson(json['role'] as String),
      info: json['information'] == null
          ? null
          : CustomerInfoModel.fromJson(
              json['information'] as Map<String, dynamic>),
      subscription: json['subscription'] == null
          ? null
          : CustomerSubscriptionModel.fromJson(
              json['subscription'] as Map<String, dynamic>),
      level: json['level'] == null
          ? null
          : LevelModel.fromJson(json['level'] as Map<String, dynamic>),
      code: json['code'] as String?,
      subEndDate: json['subscription_end_date'] as String?,
      totalPoints: (json['total_points'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'email': instance.email,
      'phone': instance.phone,
      'gender': GenderEnum.nullableToJson(instance.gender),
      'birthday': instance.birthday,
      'status': instance.status,
      'image': instance.image,
      'role': UserRoleEnum.toJson(instance.role),
      'information': instance.info,
      'subscription': instance.subscription,
      'level': instance.level,
      'code': instance.code,
      'subscription_end_date': instance.subEndDate,
      'total_points': instance.totalPoints,
      'created_at': instance.createdAt,
    };
