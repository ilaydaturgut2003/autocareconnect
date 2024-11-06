import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart'; // Import the generated AutoRoute routes

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoCare Connect Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(LoginRoute());
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(SignUpRoute());
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(ProfileRoute());
              },
              child: Text('My Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(BrowseServicesRoute());
              },
              child: Text('Browse Services'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(BookingRoute());
              },
              child: Text('Book a Service'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(ProviderDashboardRoute());
              },
              child: Text('Provider Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(HelpSupportRoute());
              },
              child: Text('Help & Support'),
            ),
          ],
        ),
      ),
    );
  }
}
