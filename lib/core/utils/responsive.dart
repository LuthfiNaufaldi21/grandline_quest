import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class Breakpoints {
  Breakpoints._();

  static const double tablet = 600;
  static const double narrowMaxWidth = 560;
  static const double wideMaxWidth = 1000;

  // Batas skala maksimal supaya elemen UI tidak raksasa saat dibuka di tablet/web
  static const double _scaleCap = 420;

  // Pakai layout 2 kolom kalau layar landscape dan cukup lebar
  static bool isWide(BoxConstraints c) =>
      c.maxWidth >= tablet && c.maxWidth > c.maxHeight;
}

// Helper ukuran UI agar dinamis mengikuti ukuran layar (responsive)
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // 1 unit = 1% dari sisi terpendek layar, dilimit oleh _scaleCap
  double get _unit =>
      math.min(MediaQuery.sizeOf(this).shortestSide, Breakpoints._scaleCap) / 100;

  double sz(double units) => _unit * units;
  double sp(double units) => _unit * units;
  double hp(double percent) => screenHeight * percent / 100;
  double wp(double percent) => screenWidth * percent / 100;
}