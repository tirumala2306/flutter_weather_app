abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final double lat;
  final double lon;

  FetchWeather({required this.lat, required this.lon});
}
