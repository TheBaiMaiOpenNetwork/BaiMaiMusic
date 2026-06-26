import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final primaryColorProvider = StateProvider<Color>((ref) => const Color(0xFF8B5CF6));

class ThemeManager {
  ThemeManager._();

  static ThemeData buildLightTheme(Color primaryColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.light);
    return ThemeData(
      useMaterial3: true, brightness: Brightness.light,
      colorScheme: colorScheme, fontFamily: 'Poppins',
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0, centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: colorScheme.surface),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 2,
        indicatorColor: primaryColor.withAlpha(51),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(128),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
    );
  }

  static ThemeData buildDarkTheme(Color primaryColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.dark);
    return ThemeData(
      useMaterial3: true, brightness: Brightness.dark,
      colorScheme: colorScheme, fontFamily: 'Poppins',
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0, centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: colorScheme.surface),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 2,
        indicatorColor: primaryColor.withAlpha(51),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(77),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
    );
  }
}
