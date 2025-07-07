import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/app/app.dart';
import 'package:wellnesstrackerapp/global/blocs/app_bloc_observer.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import '../../firebase_options.dart';

Future<void> runAppWithReporting() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      EasyLocalization.ensureInitialized();
      await configureDependencies();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final app = App();

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      Bloc.observer = AppBlocObserver();
      runApp(app);
    },
    (error, stackTrace) {
      debugPrint('runAppWithReporting error: $error');
      debugPrint('runAppWithReporting stackTrace: $stackTrace');
    },
  );
}
