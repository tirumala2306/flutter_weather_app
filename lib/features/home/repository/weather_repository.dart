import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherRepository {
  static const _apiKey = '063a381b1e60794e0cd404efe2487967';

  Future<WeatherModel> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast'
        '?lat=$lat&lon=$lon&units=metric&appid=$_apiKey';

    log('WEATHER URL: $url');

    final response = await http.get(Uri.parse(url));

    log('STATUS CODE: ${response.statusCode}');
    log('RESPONSE BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load weather');
    }

    return WeatherModel.fromJson(jsonDecode(response.body));
  }

}
