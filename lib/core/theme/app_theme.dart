import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  /// Main theme for the Glasscast app with glassmorphism design
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme (using gradient colors)
      colorScheme: ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentSecondary,
        surface: AppColors.backgroundSecondary,
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      
      // Scaffold - using gradient start color (we'll add gradient in widgets)
      scaffoldBackgroundColor: AppColors.gradientStart,
      
      // Text Theme
      textTheme: AppTextStyles.lightTextTheme,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.glassBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.glassBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: TextStyle(color: AppColors.textHint),
        labelStyle: TextStyle(color: AppColors.textSecondary),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBackground,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.glassBorder),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(color: AppColors.glassBorder),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: IconThemeData(
        color: AppColors.textSecondary,
        size: 24,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.glassBorder,
        thickness: 1,
        space: 1,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.glassBorder),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
      ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        contentTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.glassBackground,
        labelStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        side: BorderSide(color: AppColors.glassBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  /// Gradient decoration for backgrounds (matching your screenshot)
  static BoxDecoration get gradientBackground {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientStart,
          AppColors.gradientMiddle,
          AppColors.gradientEnd,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }
  
  /// Alternative gradient with more stops for smoother transition
  static BoxDecoration get gradientBackgroundSmooth {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientStart,
          Color.lerp(AppColors.gradientStart, AppColors.gradientMiddle, 0.5)!,
          AppColors.gradientMiddle,
          Color.lerp(AppColors.gradientMiddle, AppColors.gradientEnd, 0.5)!,
          AppColors.gradientEnd,
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
      ),
    );
  }
}
