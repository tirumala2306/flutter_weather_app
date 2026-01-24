import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/features/favorites/bloc/favorites_event.dart';
import 'package:glasscast/features/favorites/bloc/favorites_state.dart';
import 'package:glasscast/features/favorites/repository/favorites_repository.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteCity>(_onAddFavorite);
    on<RemoveFavoriteCity>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await repository.fetchFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteCity event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.addFavorite(event.city);
      final favorites = await repository.fetchFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteCity event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.removeFavorite(event.city);
      final favorites = await repository.fetchFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}

