import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/services/notification_service/notification_config.dart';

part 'internet_connection_state.dart';

@singleton
class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  InternetConnectionCubit() : super(InternetConnectionInitial()) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty && !results.contains(ConnectivityResult.none)) {
        if (kDebugMode) print("Internet is back 🟢");
        await get<NotaficationsService>().initialize();
      } else {
        if (kDebugMode) print("Lost internet 🔴");
      }
    });
  }
  
  Future<bool> checkInternetConnection() async {
    bool isConnected = false;
    emit(CheckInternetLoading());
    try {
      final List<ConnectivityResult> result =
          await (Connectivity().checkConnectivity());
      if (result.isNotEmpty && !result.contains(ConnectivityResult.none)) {
        isConnected = true;
        emit(InternetConnectedState("انت الان متصل بالانترنت"));
      } else {
        isConnected = false;
        emit(InternetDisconnectedState("أنت الان بدون اتصال بالانترنت"));
      }
    } catch (e) {
      isConnected = false;
      emit(CheckInternetFail(e.toString()));
    }
    return isConnected;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
