import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../app_header.dart';

@RoutePage()
class ProviderDashboardPage extends StatelessWidget {
  const ProviderDashboardPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(
        child: Text('Provider Dashboard Page'),
      ),
    );
  }
}