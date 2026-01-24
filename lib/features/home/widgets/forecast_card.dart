import 'package:flutter/material.dart';
// import 'package:glasscast/core/utils/screen_utils.dart';
import 'package:glasscast/features/home/model/weather_model.dart';
import 'package:glasscast/widgets/glass_container.dart';

class ForecastCard extends StatelessWidget {
  final ForecastModel forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      // width: ScreenUtils.width(90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${forecast.date.day}/${forecast.date.month}'),
          Text('${forecast.temp}°'),
          Text(forecast.condition),
        ],
      ),
    );
  }
}
