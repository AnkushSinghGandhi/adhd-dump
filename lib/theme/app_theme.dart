import 'package:flutter/material.dart';

class DumpMateTheme {
  // Color tokens
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlack = Color(0xFF0B0B0B);
  static const Color accentLime = Color(0xFFA3E635);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color mutedText = Color(0xFF4A4A4A);
  static const Color subtleBorder = Color(0x0A0A0A0A);
  
  // Radius tokens
  static const double radiusCard = 16.0;
  static const double radiusButton = 10.0;
  static const double radiusPill = 8.0;
  
  // Typography sizes
  static const double h1 = 34.0;
  static const double h2 = 24.0;
  static const double h3 = 20.0;
  static const double body = 16.0;
  static const double small = 13.0;
  
  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.light(
        primary: primaryBlack,
        secondary: accentLime,
        surface: cardBackground,
        background: background,
        onPrimary: Colors.white,
        onSecondary: primaryBlack,
        onSurface: primaryBlack,
        onBackground: primaryBlack,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: h1,
          fontWeight: FontWeight.bold,
          color: primaryBlack,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: h2,
          fontWeight: FontWeight.bold,
          color: primaryBlack,
          height: 1.3,
        ),
        displaySmall: TextStyle(
          fontSize: h3,
          fontWeight: FontWeight.w600,
          color: primaryBlack,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: body,
          color: primaryBlack,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: small,
          color: mutedText,
          height: 1.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryBlack),
        titleTextStyle: TextStyle(
          fontSize: h3,
          fontWeight: FontWeight.w600,
          color: primaryBlack,
        ),
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          textStyle: TextStyle(
            fontSize: body,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlack,
          side: BorderSide(color: primaryBlack, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusButton),
          ),
          textStyle: TextStyle(
            fontSize: body,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusButton),
          borderSide: BorderSide(color: accentLime, width: 2),
        ),
        hintStyle: TextStyle(color: mutedText, fontSize: body),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cardBackground,
        selectedColor: accentLime.withOpacity(0.2),
        labelStyle: TextStyle(
          color: primaryBlack,
          fontSize: small,
          fontWeight: FontWeight.w500,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusPill),
        ),
      ),
    );
  }
}
