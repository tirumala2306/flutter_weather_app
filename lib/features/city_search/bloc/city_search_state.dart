import '../model/city_model.dart';

abstract class CitySearchState {}

class CitySearchInitial extends CitySearchState {}

class CitySearchLoading extends CitySearchState {}

class CitySearchLoaded extends CitySearchState {
  final List<CityModel> cities;

  CitySearchLoaded(this.cities);
}

class CitySearchError extends CitySearchState {
  final String message;

  CitySearchError(this.message);
}

class CitySavedSuccess extends CitySearchState {}