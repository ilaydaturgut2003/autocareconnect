import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../app_header.dart';

@RoutePage()
class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Center(
        child: Text('Help & Support Page'),
      ),
    );
  }
}
