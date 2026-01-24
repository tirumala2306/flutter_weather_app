import 'package:flutter/material.dart';
import 'package:glasscast/features/home/model/weather_model.dart';
import 'package:glasscast/widgets/glass_container.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        children: [
          Text(weather.cityName),
          Text('${weather.temperature}°C'),
          Text(weather.condition),
          Text('H: ${weather.maxTemp}  L: ${weather.minTemp}'),
        ],
      ),
    );
  }
}
