// home_page.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart'; // Import the generated AutoRoute routes
import '../app_header.dart'; // Import the AppHeader

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(), // Use the AppHeader here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner Section
              Container(
                width: double.infinity,
                height: 180.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/banner.jpg'), // Make sure to add an image asset
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(height: 16.0),

              // Welcome Text
              const Text(
                'Welcome to AutoCare Connect!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Your one-stop solution for car maintenance and detailing services.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search Services',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16.0),

              // Navigation Cards
              Column(
                children: [
                  _buildNavigationCard(
                    context,
                    icon: Icons.login,
                    title: 'Login',
                    subtitle: 'Access your account',
                    route: LoginRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.app_registration,
                    title: 'Sign Up',
                    subtitle: 'Create a new account',
                    route: SignUpRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.person,
                    title: 'My Profile',
                    subtitle: 'View and edit your profile',
                    route: ProfileRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.car_repair,
                    title: 'Browse Services',
                    subtitle: 'Explore available car services',
                    route: BrowseServicesRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.book_online,
                    title: 'Book a Service',
                    subtitle: 'Schedule a service appointment',
                    route: BookingRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.dashboard,
                    title: 'Provider Dashboard',
                    subtitle: 'Manage your service offerings',
                    route: ProviderDashboardRoute(),
                  ),
                  _buildNavigationCard(
                    context,
                    icon: Icons.help,
                    title: 'Help & Support',
                    subtitle: 'Get assistance and support',
                    route: HelpSupportRoute(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create navigation cards
  Widget _buildNavigationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required PageRouteInfo route,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () => context.router.push(route),
      ),
    );
  }
}
