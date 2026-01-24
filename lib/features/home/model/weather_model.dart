class WeatherModel {
  final String cityName;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final List<ForecastModel> forecast;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List;

    return WeatherModel(
      cityName: json['city']['name'],
      temperature: (list.first['main']['temp'] as num).toDouble(),
      minTemp: (list.first['main']['temp_min'] as num).toDouble(),
      maxTemp: (list.first['main']['temp_max'] as num).toDouble(),
      condition: list.first['weather'][0]['main'],
      forecast: list
          .where((e) => e['dt_txt'].contains('12:00:00'))
          .take(5)
          .map((e) => ForecastModel.fromJson(e))
          .toList(),
    );
  }
}

class ForecastModel {
  final DateTime date;
  final double temp;
  final String condition;

  ForecastModel({
    required this.date,
    required this.temp,
    required this.condition,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.parse(json['dt_txt']),
      temp: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}
