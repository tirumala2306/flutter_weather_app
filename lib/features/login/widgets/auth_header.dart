import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Glasscast',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Minimal weather, beautifully clear',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
