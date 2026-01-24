import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/core/routes/app_routes.dart';
import 'package:glasscast/features/home/screens/home_screens.dart';
import 'package:glasscast/features/login/screens/login_screen.dart';
import 'package:glasscast/features/login/screens/register_screen.dart';
import 'package:glasscast/features/login/bloc/auth_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_state.dart';
import 'package:glasscast/features/settings/screens/settings_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.root:
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const HomeScreen();
              }
              if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_)=> const SettingsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
