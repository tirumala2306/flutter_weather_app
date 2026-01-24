import 'package:glasscast/features/city_search/model/city_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for reading and writing favorite cities in Supabase.
class FavoritesRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<CityModel>> fetchFavorites() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final List data = await _client
        .from('favorite_cities')
        .select()
        .eq('user_id', user.id);

    return data.map((row) {
      return CityModel(
        name: row['city_name'] as String,
        lat: (row['lat'] as num).toDouble(),
        lon: (row['lon'] as num).toDouble(),
        // Country might not be stored; default to empty string.
        country: (row['country'] ?? '') as String,
      );
    }).toList();
  }

  Future<void> addFavorite(CityModel city) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    await _client.from('favorite_cities').insert({
      'user_id': user.id,
      'city_name': city.name,
      'lat': city.lat,
      'lon': city.lon,
    });
  }

  Future<void> removeFavorite(CityModel city) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    await _client
        .from('favorite_cities')
        .delete()
        .eq('user_id', user.id)
        .eq('city_name', city.name)
        .eq('lat', city.lat)
        .eq('lon', city.lon);
  }
}

