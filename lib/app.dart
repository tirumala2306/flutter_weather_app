import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_event.dart';
import 'package:glasscast/features/login/repository/auth_repository.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/screen_utils.dart';

class GlasscastApp extends StatelessWidget {
  const GlasscastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthRepository>(),
        )..add(AppStarted()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Glasscast',
          theme: AppTheme.theme,
          initialRoute: AppRoutes.root,
          onGenerateRoute: AppRouter.generateRoute,
          builder: (context, child) {
            ScreenUtils.init(context);
            return child!;
          },
        ),
      ),
    );
  }
}
