import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'evaluate_customer_model.g.dart';

@JsonSerializable()
@immutable
class EvaluateCustomerModel {
  const EvaluateCustomerModel({
    String? health,
    String? psychology,
    String? behavior,
    int? plansCount,
  })  : _health = health,
        _psychology = psychology,
        _behavior = behavior,
        _plansCount = plansCount;

  final String? _health;
  final String? _psychology;
  final String? _behavior;
  final int? _plansCount;

  EvaluateCustomerModel copyWith({
    String? Function()? health,
    String? Function()? psychology,
    String? Function()? behavior,
    int? Function()? plansCount,
  }) {
    return EvaluateCustomerModel(
      health: health != null ? health() : _health,
      psychology: psychology != null ? psychology() : _psychology,
      behavior: behavior != null ? behavior() : _behavior,
      plansCount: plansCount != null ? plansCount() : _plansCount,
    );
  }

  String get health {
    if (_health == null || _health.isEmpty) {
      throw "health_required".tr();
    }
    return _health;
  }

  String get psychology {
    if (_psychology == null || _psychology.isEmpty) {
      throw "psychology_required".tr();
    }
    return _psychology;
  }

  String get behavior {
    if (_behavior == null || _behavior.isEmpty) {
      throw "behavior_required".tr();
    }
    return _behavior;
  }

  @JsonKey(name: "plans_count")
  int get plansCount {
    if (_plansCount == null) {
      throw "plans_count_required".tr();
    }
    return _plansCount;
  }

  factory EvaluateCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluateCustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluateCustomerModelToJson(this);

  factory EvaluateCustomerModel.fromString(String jsonString) =>
      EvaluateCustomerModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
