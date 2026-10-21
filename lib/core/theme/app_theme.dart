import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema aplikasi: Light (siang) dan Dark (malam) di Grand Line.
class AppTheme {
  AppTheme._();

  static const String headingFont = 'PirataOne';
  static const String bodyFont = 'Poppins';

  static ThemeData get light => _build(
        ColorScheme.fromSeed(
          seedColor: AppColors.oceanBlue,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.oceanBlue,
          onPrimary: Colors.white,
          secondary: AppColors.strawYellow,
          onSecondary: AppColors.ink,
          surface: AppColors.parchment,
          onSurface: AppColors.ink,
          error: AppColors.luffyRed,
        ),
      );

  static ThemeData get dark => _build(
        ColorScheme.fromSeed(
          seedColor: AppColors.oceanBlue,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.strawYellow,
          onPrimary: AppColors.ink,
          secondary: AppColors.strawYellow,
          onSecondary: AppColors.ink,
          surface: AppColors.nightSea,
          onSurface: AppColors.parchment,
          error: AppColors.luffyRed,
        ),
      );

  static ThemeData _build(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: bodyFont,
      scaffoldBackgroundColor: Colors.transparent,
    );
  }
}