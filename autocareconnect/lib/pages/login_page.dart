import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
