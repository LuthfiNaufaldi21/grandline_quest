import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import 'app_theme.dart';

/// Gaya teks dengan ukuran yang mengikuti layar.
class AppText {
  AppText._();

  /// Judul bergaya bajak laut (font Pirata One).
  static TextStyle heading(
    BuildContext context, {
    double size = 8,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: AppTheme.headingFont,
      fontSize: context.sp(size),
      height: 1.1,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  /// Teks isi (font Poppins).
  static TextStyle body(
    BuildContext context, {
    double size = 4,
    FontWeight weight = FontWeight.w400,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: AppTheme.bodyFont,
      fontSize: context.sp(size),
      fontWeight: weight,
      height: 1.4,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }
}