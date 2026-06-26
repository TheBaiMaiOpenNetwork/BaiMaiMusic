import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/security/security_manager.dart';
import 'core/storage/storage_initializer.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _bootstrap();
      _configureSystemUI();
      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        if (kReleaseMode) {
          SecurityManager.logError(details.exception.toString());
        }
      };
      runApp(const ProviderScope(child: BaiMaiMusicApp()));
    },
    (error, stack) {
      debugPrint('Uncaught error: $error');
      SecurityManager.logError(error.toString());
    },
  );
}

Future<void> _bootstrap() async {
  await StorageInitializer.initialize();
  await Hive.openBox(AppConstants.settingsBox);
  await Hive.openBox(AppConstants.songsBox);
  await Hive.openBox(AppConstants.playlistsBox);
  await Hive.openBox(AppConstants.downloadsBox);
  await SecurityManager.initialize();
}

void _configureSystemUI() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
