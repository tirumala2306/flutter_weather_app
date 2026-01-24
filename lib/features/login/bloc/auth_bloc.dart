import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_event.dart';
import 'package:glasscast/features/login/bloc/auth_state.dart';
import 'package:glasscast/features/login/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLogin);
    on<RegisterSubmitted>(_onRegister);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    // Always start unauthenticated and clear any persisted Supabase session.
    emit(AuthLoading());
    try {
      await _authRepository.logout();
    } catch (e) {
      log('Error clearing session on start: $e');
    }
    emit(AuthUnauthenticated());
  }

  Future<void> _onLogin(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRegister(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.register(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    log('LOGOUT REQUESTED');
    await _authRepository.logout();
    log('LOGOUT DONE');
    emit(AuthUnauthenticated());
  }
}
