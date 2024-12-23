import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'router.gr.dart'; 

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const AppHeader({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('AutoCare Connect'),
      automaticallyImplyLeading: showBackButton,
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            context.pushRoute(HomeRoute());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
