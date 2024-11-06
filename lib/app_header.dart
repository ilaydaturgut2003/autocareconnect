// lib/app_header.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'router.gr.dart'; // Import your generated routes

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('AutoCare Connect'),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate to Home Page
            context.pushRoute(HomeRoute());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
