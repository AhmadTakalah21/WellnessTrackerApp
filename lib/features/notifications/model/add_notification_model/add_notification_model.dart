import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_notification_model.g.dart';

@JsonSerializable()
@immutable
class AddNotificationModel {
  const AddNotificationModel({
    int? customerId,
    String? title,
    String? body,
  })  : _customerId = customerId,
        _title = title,
        _body = body;

  @JsonKey(name: "customer_id")
  final int? _customerId;
  final String? _title;
  final String? _body;

  AddNotificationModel copyWith({
    int? Function()? customerId,
    String? Function()? title,
    String? Function()? body,
  }) {
    return AddNotificationModel(
      customerId: customerId != null ? customerId() : _customerId,
      title: title != null ? title() : _title,
      body: body != null ? body() : _body,
    );
  }

  int get customerId {
    if (_customerId == null) {
      throw "customer_required".tr();
    }
    return _customerId;
  }

  String get title {
    if (_title == null || _title.isEmpty) {
      throw "title_required".tr();
    }
    return _title;
  }

  String get body {
    if (_body == null || _body.isEmpty) {
      throw "body_required".tr();
    }
    return _body;
  }

  factory AddNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationModelToJson(this);

  factory AddNotificationModel.fromString(String jsonString) =>
      AddNotificationModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
