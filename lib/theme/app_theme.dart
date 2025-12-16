import 'package:flutter/material.dart';

class AppTheme {
  // Background Colors - Black/Charcoal
  static const Color backgroundBlack = Color(0xFF0B0B0D);
  static const Color backgroundBlackLight = Color(0xFF111214);
  
  // Dark Glass Panels
  static const Color darkGlass = Color(0xFF1A1A1C);
  static const Color darkGlassLight = Color(0xFF222326);
  
  // Frosted Glass Overlay
  static Color frostedGlass = Colors.white.withValues(alpha: 0.05);
  static Color frostedGlassLight = Colors.white.withValues(alpha: 0.08);
  
  // Primary Neon Yellow
  static const Color neonYellow = Color(0xFFE8FF2A);
  static const Color neonYellowLight = Color(0xFFF5FF3D);
  
  // Text Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondaryGray = Color(0xFFA7A7A7);
  
  // Thin Lines
  static Color thinLine = Colors.white.withValues(alpha: 0.08);
  
  // Legacy colors (kept for compatibility)
  static const Color darkNavyBlue = backgroundBlack;
  static const Color darkNavyBlueLight = backgroundBlackLight;
  static const Color deepBlue = darkGlass;
  static const Color deepBlueLight = darkGlassLight;
  static const Color goldenYellow = neonYellow;
  static const Color goldenYellowLight = neonYellowLight;
  static const Color lightGray = secondaryGray;
  static const Color softRed = Color(0xFFFF4F5E);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: neonYellow,
      scaffoldBackgroundColor: backgroundBlack,
      colorScheme: const ColorScheme.dark(
        primary: neonYellow,
        secondary: neonYellowLight,
        tertiary: neonYellow,
        surface: darkGlass,
        onPrimary: backgroundBlack,
        onSecondary: backgroundBlack,
        onSurface: white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: darkGlass,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonYellow,
          foregroundColor: backgroundBlack,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: neonYellow,
        foregroundColor: backgroundBlack,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          color: white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          color: white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: secondaryGray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: white,
          fontSize: 16,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          color: white,
          fontSize: 14,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          color: secondaryGray,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: secondaryGray,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          color: secondaryGray,
          fontSize: 10,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: neonYellow,
        unselectedItemColor: secondaryGray,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerColor: thinLine,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: neonYellow,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: neonYellow,
      scaffoldBackgroundColor: Colors.grey[50],
      colorScheme: ColorScheme.light(
        primary: neonYellow,
        secondary: neonYellowLight,
        tertiary: neonYellow,
        surface: Colors.white,
        onPrimary: backgroundBlack,
        onSecondary: backgroundBlack,
        onSurface: backgroundBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: backgroundBlack,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonYellow,
          foregroundColor: backgroundBlack,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: neonYellow,
        foregroundColor: backgroundBlack,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: backgroundBlack,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: backgroundBlack,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          color: backgroundBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          color: backgroundBlack,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          color: backgroundBlack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: backgroundBlack,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: backgroundBlack,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: backgroundBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: secondaryGray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: backgroundBlack,
          fontSize: 16,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          color: backgroundBlack,
          fontSize: 14,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          color: secondaryGray,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: backgroundBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: secondaryGray,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          color: secondaryGray,
          fontSize: 10,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: neonYellow,
        unselectedItemColor: secondaryGray,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerColor: Colors.grey[300],
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: neonYellow,
      ),
    );
  }
}
