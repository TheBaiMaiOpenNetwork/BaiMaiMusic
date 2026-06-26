import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_manager.dart';
import 'core/providers/locale_provider.dart';
import 'screens/splash/splash_screen.dart';

class BaiMaiMusicApp extends ConsumerWidget {
  const BaiMaiMusicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'BaiMai Music',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeManager.buildLightTheme(primaryColor),
      darkTheme: ThemeManager.buildDarkTheme(primaryColor),
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}
