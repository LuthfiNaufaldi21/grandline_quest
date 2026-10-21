import 'package:flutter/material.dart';

// Palet warna custom (Tema One Piece)
class AppColors {
  AppColors._();

  // Background laut & langit
  static const Color oceanBlue = Color(0xFF1363A8);
  static const Color skyBlue = Color(0xFF8FD3F4);
  static const Color nightSky = Color(0xFF060F1F);
  static const Color nightSea = Color(0xFF102A4C);

  // Warna aksen
  static const Color strawYellow = Color(0xFFF7C325);
  static const Color luffyRed = Color(0xFFD62828);
  static const Color success = Color(0xFF2E9E5B);

  // Warna kertas/kertas buronan
  static const Color parchment = Color(0xFFF6E7C1);
  static const Color parchmentDark = Color(0xFFE3C98F);
  static const Color ink = Color(0xFF3A2614);

  // Gradasi untuk background halaman
  static const List<Color> lightGradient = [skyBlue, Color(0xFFFFF1C9)];
  static const List<Color> darkGradient = [nightSky, nightSea];
}