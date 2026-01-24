import 'package:glasscast/features/city_search/model/city_model.dart';

abstract class CitySearchEvent {}

class CitySearchRequested extends CitySearchEvent {
  final String query;

  CitySearchRequested(this.query);
}

class SearchCity extends CitySearchEvent {
  final String query;
  SearchCity(this.query);
}

class SaveFavoriteCity extends CitySearchEvent {
  final CityModel city;
  SaveFavoriteCity(this.city);
}