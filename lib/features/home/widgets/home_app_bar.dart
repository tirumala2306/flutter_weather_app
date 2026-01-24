import 'package:flutter/material.dart';
import 'package:glasscast/core/routes/app_routes.dart';
import 'package:glasscast/core/theme/app_colors.dart';
import 'package:glasscast/core/utils/screen_utils.dart';
import 'package:glasscast/features/city_search/screens/city_search_screen.dart';
import 'package:glasscast/features/home/bloc/weather_bloc.dart';
import 'package:glasscast/features/home/bloc/weather_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // App title
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtils.height(20)),
            Text(
              'Glasscast',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SizedBox(height: ScreenUtils.height(4)),
            Text(
              'Weather Forecast',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),

        // Actions
        Row(
          children: [
            // Search city
            IconButton(
              icon: const Icon(Icons.search),
              color: AppColors.textPrimary,
              onPressed: () async {
                final city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CitySearchScreen(),
                  ),
                );

                if (city != null && context.mounted) {
                  context.read<WeatherBloc>().add(
                        FetchWeather(
                          lat: city.lat,
                          lon: city.lon,
                        ),
                      );
                }
              },
            ),

            // Settings (future use)
            IconButton(
              icon: const Icon(Icons.settings),
              color: AppColors.textPrimary,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),
          ],
        ),
      ],
    );
  }
}
