import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlexoraColors {
  static const background = Color(0xFF131313);
  static const surface = Color(0xFF131313);
  static const surfaceDim = Color(0xFF131313);
  static const surfaceBright = Color(0xFF393939);
  static const surfaceContainerLowest = Color(0xFF0E0E0E);
  static const surfaceContainerLow = Color(0xFF1C1B1B);
  static const surfaceContainer = Color(0xFF201F1F);
  static const surfaceContainerHigh = Color(0xFF2A2A2A);
  static const surfaceContainerHighest = Color(0xFF353534);

  static const primary = Color(0xFFFFFFFF);
  static const onPrimary = Color(0xFF1A1C1C);

  static const secondary = Color(0xFFE9C349);
  static const onSecondary = Color(0xFF241A00);

  static const onSurface = Color(0xFFE5E2E1);
  static const onSurfaceVariant = Color(0xFFC6C6C6);

  static const outline = Color(0xFF919191);
  static const outlineVariant = Color(0xFF474747);
}

final flexoraTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: FlexoraColors.background,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.manrope(
      fontSize: 64,
      fontWeight: FontWeight.w200,
      color: FlexoraColors.primary,
    ),
    displayMedium: GoogleFonts.manrope(
      fontSize: 48,
      fontWeight: FontWeight.w300,
      color: FlexoraColors.primary,
    ),
    headlineMedium: GoogleFonts.manrope(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: FlexoraColors.primary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: FlexoraColors.onSurface,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 2.5,
      color: FlexoraColors.secondary,
    ),
  ),
);
