import 'package:flutter/material.dart';
import 'config.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF6366F1);
  static const Color primaryPurpleLight = Color(0xFF8B5CF6);
  static const Color primaryPurpleDark = Color(0xFF4F46E5);

  static const Color secondaryCyan = Color(0xFF06B6D4);
  static const Color secondaryCyanLight = Color(0xFF22D3EE);
  static const Color secondaryCyanDark = Color(0xFF0891B2);

  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentGreenLight = Color(0xFF34D399);
  static const Color accentGreenDark = Color(0xFF059669);

  static const Color activeGreen = Color(0xFF10B981);
  static const Color inactiveRed = Color(0xFFEF4444);
  static const Color inactiveGray = Color(0xFF6B7280);

  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color backgroundCard = Color(0xFF1E293B);
  static const Color backgroundLight = Color(0xFF334155);
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textLight = Color(0xFF94A3B8);

  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowMedium = Color(0x29000000);
  static const Color shadowDark = Color(0xFF000000);
}

// Colors that make the app look fancy, not like a default theme

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryPurple,
      primaryColorLight: AppColors.primaryPurpleLight,
      primaryColorDark: AppColors.primaryPurpleDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.backgroundCard,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundCard,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        shadowColor: AppColors.shadowDark,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.backgroundLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.backgroundLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inactiveRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inactiveRed, width: 2),
        ),
        labelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: AppColors.textLight,
          fontSize: 14,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondaryCyan,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.textLight,
        ),
      ),

      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryPurple,
        primaryContainer: AppColors.primaryPurpleLight,
        secondary: AppColors.secondaryCyan,
        secondaryContainer: AppColors.secondaryCyanLight,
        surface: AppColors.backgroundCard,
        background: AppColors.backgroundDark,
        error: AppColors.inactiveRed,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
    );
  }
}

// Theme that makes buttons look clickable and text readable

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppBorderRadius {
  static const double xs = 2.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 24.0;
}

class AppAssets {
  static const String backgroundImage = 'assets/images/employee_background.jpg';
}

class ApiConfig {
  static String get baseUrl => Config.apiBaseUrl;

  static const String employeesEndpoint = "/employees";

  static const Map<String, String> jsonHeaders = {
    "Content-Type": "application/json"
  };

  static int get connectionTimeout => Config.apiTimeout;
  static int get receiveTimeout => Config.apiTimeout;
}

// Because magic numbers are for wizards, not developers