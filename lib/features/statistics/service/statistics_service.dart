import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/statistics/model/stats_model/stats_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'statistics_service_imp.dart';

abstract class StatisticsService {
  Future<StatsModel> getStats();
}
