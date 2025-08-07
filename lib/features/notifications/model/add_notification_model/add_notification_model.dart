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
  })  : _title = title,
        _message = message;

  @JsonKey(name: 'is_all')
  final String isAll;
  final String? _title;
  final String? _message;

  AddNotificationModel copyWith({
    String? isAll,
    String? Function()? title,
    String? Function()? message,
  }) {
    return AddNotificationModel(
      isAll: isAll ?? this.isAll,
      title: title != null ? title() : _title,
      message: message != null ? message() : _message,
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

  factory AddNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationModelToJson(this);

  factory AddNotificationModel.fromString(String jsonString) =>
      AddNotificationModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
