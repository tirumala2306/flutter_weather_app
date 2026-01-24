import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Gradient background widget matching the GlassCast app design
/// Use this as the base container for your screens
class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool useSmooth;

  const GradientBackground({
    super.key,
    required this.child,
    this.useSmooth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: useSmooth 
          ? AppTheme.gradientBackgroundSmooth 
          : AppTheme.gradientBackground,
      child: child,
    );
  }
}
