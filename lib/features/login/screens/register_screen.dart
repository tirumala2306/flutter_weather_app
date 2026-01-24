import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                    padding: EdgeInsets.only(
                      left: ScreenUtils.width(16),
                      right: ScreenUtils.width(16),
                      top: ScreenUtils.height(16),
                      bottom: ScreenUtils.height(24),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GlassContainer(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AuthHeader(),
                                SizedBox(height: ScreenUtils.height(24)),
                        
                                GlassTextField(
                                  hint: 'Full Name',
                                  controller: _nameController,
                                ),
                                SizedBox(height: ScreenUtils.height(16)),
                        
                                GlassTextField(
                                  hint: 'Email',
                                  controller: _emailController,
                                ),
                                SizedBox(height: ScreenUtils.height(16)),
                        
                                GlassTextField(
                                  hint: 'Password',
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: ScreenUtils.height(16)),
                        
                                GlassTextField(
                                  hint: 'Confirm Password',
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: ScreenUtils.height(24)),
                        
                                GlassButton(
                                  text: isLoading
                                      ? 'Creating account...'
                                      : 'Create Account',
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          context.read<AuthBloc>().add(
                                                RegisterSubmitted(
                                                  name: _nameController.text.trim(),
                                                  email:
                                                      _emailController.text.trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                        },
                                ),
                        
                                SizedBox(height: ScreenUtils.height(16)),
                        
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                        },
                                  child: const Text(
                                    'Already have an account? Login',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
