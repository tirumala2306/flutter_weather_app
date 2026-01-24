import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/features/city_search/bloc/city_serach_event.dart';
import 'city_search_state.dart';
import '../repository/city_repository.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository repository;

  CitySearchBloc(this.repository) : super(CitySearchInitial()) {
    on<SearchCity>(_onSearchCity);
    on<SaveFavoriteCity>(_onSaveFavoriteCity);
  }

  Future<void> _onSearchCity(
    SearchCity event,
    Emitter<CitySearchState> emit,
  ) async {
    emit(CitySearchLoading());
    try {
      final cities = await repository.searchCity(event.query);
      emit(CitySearchLoaded(cities));
    } catch (e) {
      emit(CitySearchError(e.toString()));
    }
  }

  Future<void> _onSaveFavoriteCity(
    SaveFavoriteCity event,
    Emitter<CitySearchState> emit,
  ) async {
    try {
      await repository.saveFavoriteCity(event.city);
      emit(CitySavedSuccess());
    } catch (e) {
      emit(CitySearchError(e.toString()));
    }
  }
}
