import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProviderDashboardPage extends StatelessWidget {
  const ProviderDashboardPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Provider Dashboard Page'),
      ),
    );
  }
}
