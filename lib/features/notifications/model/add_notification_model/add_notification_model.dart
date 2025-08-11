import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_notification_model.g.dart';

@JsonSerializable()
@immutable
class AddNotificationModel {
  const AddNotificationModel({
    this.isAll = "0",
    String? title,
    String? message,
    String? time,
    String? tz,
  })  : _title = title,
        _message = message,
        _time = time,
        _tz = tz;

  @JsonKey(name: 'is_all')
  final String isAll;
  final String? _title;
  final String? _message;

  /// صيغة متوقعة: HH:mm (24h) مثل "09:30" أو "22:05"
  @JsonKey(name: 'time')
  final String? _time;

  /// IANA Time Zone مثل "Europe/Bucharest" أو "Asia/Damascus"
  /// هذا اختياري لكنه يضمن تحويل صحيح إلى UTC في السيرفر
  @JsonKey(name: 'tz')
  final String? _tz;

  AddNotificationModel copyWith({
    String? isAll,
    String? Function()? title,
    String? Function()? message,
    String? Function()? time,
    String? Function()? tz,
  }) {
    return AddNotificationModel(
      isAll: isAll ?? this.isAll,
      title: title != null ? title() : _title,
      message: message != null ? message() : _message,
      time: time != null ? time() : _time,
      tz: tz != null ? tz() : _tz,
    );
  }

  String get title {
    if (_title == null || _title.isEmpty) {
      throw "title_required".tr();
    }
    return _title;
  }

  String get message {
    if (_message == null || _message.isEmpty) {
      throw "message_required".tr();
    }
    return _message;
  }

  String? get time => _time;

  /// اختياري: المنطقة الزمنية إن أردت فرضها
  String? get tz => _tz;

  factory AddNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationModelToJson(this);

  factory AddNotificationModel.fromString(String jsonString) =>
      AddNotificationModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
