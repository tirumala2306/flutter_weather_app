import 'package:flutter/material.dart';

class AppColors {
  // Gradient Backgrounds (from your app screenshot)
  static const Color gradientStart = Color(0xFF1E3A8A); // Deep blue (top)
  static const Color gradientMiddle = Color(0xFF6366F1); // Indigo blue (middle)
  static const Color gradientEnd = Color(0xFF8B5CF6); // Purple (bottom)
  
  // Background colors for solid use
  static const Color backgroundPrimary = Color(0xFF1E3A8A); // Deep blue
  static const Color backgroundSecondary = Color(0xFF6366F1); // Indigo
  static const Color backgroundTertiary = Color(0xFF8B5CF6); // Purple

  // Glass morphism effects
  static Color glassBackground = Colors.white.withValues(alpha: 0.15);
  static Color glassBorder = Colors.white.withValues(alpha: 0.2);
  static Color glassLight = Colors.white.withValues(alpha: 0.1);
  static Color glassDark = Colors.white.withValues(alpha: 0.25);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textHint = Colors.white54;

  // Action colors
  static Color buttonBackground = Colors.white.withValues(alpha: 0.2);
  static const Color accent = Color(0xFF7DD3FC); // Light blue accent
  static const Color accentSecondary = Color(0xFF60A5FA); // Sky blue

  // Status colors
  static const Color error = Color(0xFFEF4444); // Red
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color info = Color(0xFF3B82F6); // Blue
  
  // Weather-specific colors
  static const Color sunny = Color(0xFFFBBF24); // Yellow
  static const Color cloudy = Color(0xFF9CA3AF); // Gray
  static const Color rainy = Color(0xFF60A5FA); // Blue
  static const Color stormy = Color(0xFF6B7280); // Dark gray
}
