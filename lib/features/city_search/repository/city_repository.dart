import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/city_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CityRepository {
  final _client = Supabase.instance.client;
  static const _apiKey = '063a381b1e60794e0cd404efe2487967';

  Future<List<CityModel>> searchCity(String query) async {
    final url =
        'https://api.openweathermap.org/geo/1.0/direct'
        '?q=$query&limit=5&appid=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to search city');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => CityModel.fromJson(e)).toList();
  }

   /// Save favorite city (Supabase)
  Future<void> saveFavoriteCity(CityModel city) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _client.from('favorite_cities').insert({
      'user_id': user.id,
      'city_name': city.name,
      'lat': city.lat,
      'lon': city.lon,
    });
  }
}
