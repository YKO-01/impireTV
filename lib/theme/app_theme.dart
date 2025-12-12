import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors - Dark Navy Blue
  static const Color darkNavyBlue = Color(0xFF0A1124);
  static const Color darkNavyBlueLight = Color(0xFF0D1A33);
  
  // Deep Blue - Cards & Sections
  static const Color deepBlue = Color(0xFF132040);
  static const Color deepBlueLight = Color(0xFF1A2C4E);
  
  // Accent Colors - Bright Blue
  static const Color brightBlue = Color(0xFF3A7BFF);
  static const Color brightBlueLight = Color(0xFF4D8BFF);
  
  // Cyan / Light Blue
  static const Color cyan = Color(0xFF5AC8FA);
  static const Color cyanLight = Color(0xFF6ED0FF);
  
  // Secondary Accent Colors - Golden Yellow
  static const Color goldenYellow = Color(0xFFF0C75E);
  static const Color goldenYellowLight = Color(0xFFFFCC66);
  
  // Orange
  static const Color orange = Color(0xFFFF9E4A);
  static const Color orangeLight = Color(0xFFFFA862);
  
  // Text Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFA7B0C3);
  
  // Optional - Soft Red
  static const Color softRed = Color(0xFFFF4F5E);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: brightBlue,
      scaffoldBackgroundColor: darkNavyBlue,
      colorScheme: const ColorScheme.dark(
        primary: brightBlue,
        secondary: cyan,
        tertiary: goldenYellow,
        surface: deepBlue,
        onPrimary: white,
        onSecondary: white,
        onSurface: white,
        onBackground: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: deepBlue,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: deepBlue,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brightBlue,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: white, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: white, fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: white, fontSize: 24, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: white, fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: white, fontSize: 14, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: lightGray, fontSize: 12, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: white, fontSize: 16),
        bodyMedium: TextStyle(color: white, fontSize: 14),
        bodySmall: TextStyle(color: lightGray, fontSize: 12),
        labelLarge: TextStyle(color: white, fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: lightGray, fontSize: 12),
        labelSmall: TextStyle(color: lightGray, fontSize: 10),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: deepBlue,
        selectedItemColor: brightBlue,
        unselectedItemColor: lightGray,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
      ),
      dividerColor: deepBlueLight,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: brightBlue,
      scaffoldBackgroundColor: Colors.grey[50],
      colorScheme: ColorScheme.light(
        primary: brightBlue,
        secondary: cyan,
        tertiary: goldenYellow,
        surface: Colors.white,
        onPrimary: white,
        onSecondary: white,
        onSurface: darkNavyBlue,
        onBackground: darkNavyBlue,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: darkNavyBlue,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brightBlue,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: darkNavyBlue, fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: darkNavyBlue, fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: darkNavyBlue, fontSize: 24, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: darkNavyBlue, fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: darkNavyBlue, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: darkNavyBlue, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: darkNavyBlue, fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: darkNavyBlue, fontSize: 14, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: lightGray, fontSize: 12, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: darkNavyBlue, fontSize: 16),
        bodyMedium: TextStyle(color: darkNavyBlue, fontSize: 14),
        bodySmall: TextStyle(color: lightGray, fontSize: 12),
        labelLarge: TextStyle(color: darkNavyBlue, fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: lightGray, fontSize: 12),
        labelSmall: TextStyle(color: lightGray, fontSize: 10),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: brightBlue,
        unselectedItemColor: lightGray,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
      ),
      dividerColor: Colors.grey[300],
    );
  }
}

