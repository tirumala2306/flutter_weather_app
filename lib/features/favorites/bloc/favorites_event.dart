import 'package:glasscast/features/city_search/model/city_model.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddFavoriteCity extends FavoritesEvent {
  final CityModel city;

  AddFavoriteCity(this.city);
}

class RemoveFavoriteCity extends FavoritesEvent {
  final CityModel city;

  RemoveFavoriteCity(this.city);
}

