import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/core/theme/app_colors.dart';
import 'package:glasscast/core/utils/screen_utils.dart';
import 'package:glasscast/features/login/bloc/auth_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_event.dart';
import 'package:glasscast/widgets/glass_container.dart';
import 'package:glasscast/widgets/gradient_background.dart';
import '../widgets/settings_tile.dart';
import '../widgets/unit_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtils.width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: AppColors.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils.height(24)),

                // User Info (optional - add if you have user data)
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.glassLight,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Logged in as',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'sai@gmail.com',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils.height(24)),

                const Text(
                  'Preferences',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: ScreenUtils.height(16)),

                const SettingsTile(
                  title: 'Temperature Unit',
                  subtitle: 'Celsius (°C)',
                  icon: Icons.thermostat,
                  trailing: UnitToggle(),
                ),

                SizedBox(height: ScreenUtils.height(24)),

                SettingsTile(
                  title: 'Logout',
                  icon: Icons.logout,
                  iconColor: AppColors.error,
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
