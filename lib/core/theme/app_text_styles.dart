import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static TextTheme lightTextTheme = AppFonts.inter.copyWith(
    // Display styles - for major headings
    displayLarge: const TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: -0.25,
    ),
    displayMedium: const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    
    // Headline styles - for section headers
    headlineLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 0,
    ),
    headlineMedium: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    
    // Title styles - for card headers, dialog titles
    titleLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      letterSpacing: 0.15,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      letterSpacing: 0.1,
    ),
    
    // Body styles - for regular content
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 0.5,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 0.25,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
      letterSpacing: 0.4,
    ),
    
    // Label styles - for buttons, chips
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: 0.1,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.5,
    ),
    labelSmall: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
      letterSpacing: 0.5,
    ),
  );

  // Custom text styles for specific use cases
  static TextStyle get subtitle => TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get hint => TextStyle(
    fontSize: 14,
    color: AppColors.textHint,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get button => TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle get weatherTemp => const TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: -2,
  );

  static TextStyle get weatherDescription => TextStyle(
    fontSize: 18,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
  );
}
