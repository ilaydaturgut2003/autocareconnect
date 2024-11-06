import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class BrowseServicesPage extends StatelessWidget {
  const BrowseServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BrowseService Page'),
      ),
    );
  }
}
