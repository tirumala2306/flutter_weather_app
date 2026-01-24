import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw Exception('Login failed');
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Registration failed');
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  bool get isLoggedIn =>
      _client.auth.currentSession != null;
}
