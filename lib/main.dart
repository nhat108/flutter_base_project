import 'dart:async';

import 'package:minakomi/bloc_manager.dart';
import 'package:minakomi/config/env.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(kReleaseMode);
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kReleaseMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      AppConfig().setAppConfig(
        appEnvironment: AppEnvironment.prod,
        baseUrl: '',
        merchantId: '',
        stripePublicKey: '',
        googleAPIKey: '',
        userPoolId: '',
        clientId: '',
      );

      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('first_run') ?? true) {
        print("first run is true");
        FlutterSecureStorage storage = const FlutterSecureStorage();

        await storage.deleteAll();

        await prefs.setBool('first_run', false);
      }
    } catch (e) {
      print(e);
    }

    BlocOverrides.runZoned(
      () => runApp(EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: BlocManager())),
      blocObserver: SimpleBlocObserver(),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
