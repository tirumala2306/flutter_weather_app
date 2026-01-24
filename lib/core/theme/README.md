# GlassCast Theme System

This directory contains the comprehensive theming system for the GlassCast weather app, featuring a beautiful glassmorphism design.

## Theme Files

### 1. `app_colors.dart`
Defines all color constants used throughout the app:
- **Background colors**: Primary, secondary, tertiary gradients
- **Glass effects**: Semi-transparent backgrounds and borders
- **Text colors**: Primary, secondary, hint
- **Action colors**: Buttons, accents
- **Status colors**: Error states

### 2. `app_fonts.dart`
Manages font families:
- Primary font: **Inter** (clean, modern)
- Secondary font: **Poppins** (alternative)

### 3. `app_text_styles.dart`
Comprehensive text styles following Material Design 3:
- Display styles (57, 45, 36)
- Headline styles (32, 28, 24)
- Title styles (22, 16, 14)
- Body styles (16, 14, 12)
- Label styles (14, 12, 11)
- Custom styles for weather-specific UI

### 4. `app_theme.dart`
Complete Material Theme configuration with glassmorphism:
- Color schemes
- Component themes (buttons, inputs, cards)
- Typography
- Spacing and shapes

## Usage Examples

### Using Colors

```dart
import 'package:glasscast/core/theme/app_colors.dart';

// Solid background
Container(
  color: AppColors.backgroundPrimary,
)

// Gradient background (recommended)
import 'package:glasscast/widgets/gradient_background.dart';

GradientBackground(
  child: YourWidget(),
)

// Or use the gradient directly
Container(
  decoration: AppTheme.gradientBackground,
  child: YourWidget(),
)

// Glass effect
Container(
  decoration: BoxDecoration(
    color: AppColors.glassBackground,
    border: Border.all(color: AppColors.glassBorder),
    borderRadius: BorderRadius.circular(16),
  ),
)

// Text
Text(
  'Hello',
  style: TextStyle(color: AppColors.textPrimary),
)

// Accent colors
Icon(
  Icons.favorite,
  color: AppColors.accent,
)
```

### Using Text Styles

```dart
import 'package:flutter/material.dart';

// Use theme text styles
Text(
  'Welcome to GlassCast',
  style: Theme.of(context).textTheme.headlineLarge,
)

// Or use custom styles
import 'package:glasscast/core/theme/app_text_styles.dart';

Text(
  '72°',
  style: AppTextStyles.weatherTemp,
)

Text(
  'Partly Cloudy',
  style: AppTextStyles.weatherDescription,
)
```

### Using Theme Components

```dart
// Buttons automatically use theme
ElevatedButton(
  onPressed: () {},
  child: Text('Login'),
)

// Text fields automatically styled
TextField(
  decoration: InputDecoration(
    hintText: 'Enter email',
    prefixIcon: Icon(Icons.email),
  ),
)

// Cards with glass effect
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Weather Info'),
  ),
)
```

### Creating Custom Glass Widgets

```dart
import 'package:glasscast/widgets/glass_container.dart';

GlassContainer(
  blur: 10,
  opacity: 0.15,
  borderRadius: BorderRadius.circular(20),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Text('Glass Effect'),
  ),
)
```

## Design Principles

1. **Glassmorphism**: Semi-transparent backgrounds with blur effects
2. **Consistency**: All colors and styles centralized
3. **Accessibility**: Proper contrast ratios for text
4. **Responsiveness**: Styles adapt to different screen sizes
5. **Material Design 3**: Following latest design guidelines

## Color Palette

**Gradient Colors** (from your app design):
- **Gradient Start**: `#1E3A8A` (Deep blue - top)
- **Gradient Middle**: `#6366F1` (Indigo blue - middle)
- **Gradient End**: `#8B5CF6` (Purple - bottom)

**Accent Colors**:
- **Primary Accent**: `#7DD3FC` (Light sky blue)
- **Secondary Accent**: `#60A5FA` (Sky blue)

**Glass Effects**:
- **Glass Background**: `rgba(255, 255, 255, 0.15)` (Frosted white)
- **Glass Border**: `rgba(255, 255, 255, 0.2)` (Frosted border)

**Status Colors**:
- **Error**: `#EF4444` (Red)
- **Success**: `#10B981` (Green)
- **Warning**: `#F59E0B` (Amber)
- **Info**: `#3B82F6` (Blue)

**Weather Colors**:
- **Sunny**: `#FBBF24` (Yellow)
- **Cloudy**: `#9CA3AF` (Gray)
- **Rainy**: `#60A5FA` (Blue)
- **Stormy**: `#6B7280` (Dark gray)

## Customization

To customize the theme:

1. Update colors in `app_colors.dart`
2. Adjust text styles in `app_text_styles.dart`
3. Modify component themes in `app_theme.dart`
4. Changes will automatically apply app-wide

## Best Practices

1. Always use theme colors instead of hardcoded colors
2. Use theme text styles instead of inline TextStyle
3. Leverage built-in component themes
4. Create reusable glass widgets for consistency
5. Test on both light and dark backgrounds

## Theme Integration

The theme is applied in `lib/app.dart`:

```dart
MaterialApp(
  theme: AppTheme.theme,
  // ... other properties
)
```

All screens and widgets automatically inherit these styles.
