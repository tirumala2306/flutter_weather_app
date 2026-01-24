import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/core/theme/app_colors.dart';
import 'package:glasscast/features/settings/bloc/temperature_unit_cubit.dart';

class UnitToggle extends StatelessWidget {
  const UnitToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
      builder: (context, unit) {
        final isCelsius = unit == TemperatureUnit.celsius;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celsius/Fahrenheit indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                isCelsius ? '°C' : '°F',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Toggle Switch
            Transform.scale(
              scale: 0.85,
              child: Switch(
                value: isCelsius,
                activeColor: Colors.white,
                activeTrackColor: AppColors.accent,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: AppColors.glassBackground,
                onChanged: (_) {
                  context.read<TemperatureUnitCubit>().toggle();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
