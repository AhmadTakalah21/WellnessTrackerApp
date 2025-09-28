import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part "splash_service_imp.dart";

abstract class SplashSerivce {
  Future<bool> checkVersion();
}
