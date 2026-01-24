import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/core/routes/app_routes.dart';
import 'package:glasscast/core/theme/app_colors.dart';
import 'package:glasscast/core/utils/screen_utils.dart';
import 'package:glasscast/features/login/bloc/auth_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_event.dart';
import 'package:glasscast/features/login/bloc/auth_state.dart';
import 'package:glasscast/widgets/glass_button.dart';
import 'package:glasscast/widgets/glass_container.dart';
import 'package:glasscast/widgets/glass_text_field.dart';
import 'package:glasscast/widgets/gradient_background.dart';
import '../widgets/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: GradientBackground(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: GlassContainer(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const AuthHeader(),
                              SizedBox(height: ScreenUtils.height(24)),
                              GlassTextField(
                                hint: 'Email',
                                controller: _emailController,
                              ),
                              const SizedBox(height: 16),
                              GlassTextField(
                                hint: 'Password',
                                controller: _passwordController,
                                obscureText: true,
                              ),
                              const SizedBox(height: 24),
                              GlassButton(
                                text: isLoading ? 'Logging in...' : 'Login',
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        context.read<AuthBloc>().add(
                                              LoginSubmitted(
                                                email: _emailController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                      },
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.register,
                                        );
                                      },
                                child: const Text(
                                  'Create an account',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
