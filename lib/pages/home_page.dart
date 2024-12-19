// home_page.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:autocareconnect/router.gr.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For FirebaseFirestore
import 'package:auto_route/auto_route.dart'; // For AutoRoute navigation
import 'package:autocareconnect/router.gr.dart'; // Ensure the route definitions are imported
import '../app_header.dart'; 
import '../router.gr.dart';
import '../router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const AppHeader(showBackButton: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 180.0,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.jpg'),
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
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16.0),

              // Navigation Cards
              if (user == null) ...[
                _buildNavigationCard(
                  context,
                  icon: Icons.login,
                  title: 'Login',
                  subtitle: 'Access your account',
                  route: const LoginRoute(),
                ),
                _buildNavigationCard(
                  context,
                  icon: Icons.app_registration,
                  title: 'Sign Up',
                  subtitle: 'Create a new account',
                  route: const SignUpRoute(),
                ),
              ],
              if (user != null)
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData) return const SizedBox.shrink();

                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    final role = data?['role'] ?? 'user';

                    // Role-Based Navigation
                    if (role == 'user') {
                      return _buildNavigationCard(
                        context,
                        icon: Icons.assignment,
                        title: 'Apply to Become a Provider',
                        subtitle: 'Start your provider application process',
                        route: const ApplicationRoute(),
                      );
                    } else if (role == 'applicant') {
                      return _buildNavigationCard(
                        context,
                        icon: Icons.info,
                        title: 'Application Status',
                        subtitle: 'Check your application status',
                        route: const ApplicationStatusRoute(),
                      );
                    } else if (role == 'provider') {
                      return _buildNavigationCard(
                        context,
                        icon: Icons.dashboard,
                        title: 'Provider Dashboard',
                        subtitle: 'Manage your service offerings',
                        route: ProviderDashboardRoute(userId: user.uid),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              _buildNavigationCard(
                context,
                icon: Icons.person,
                title: 'My Profile',
                subtitle: 'View and edit your profile',
                route: const ProfileRoute(),
              ),
              _buildNavigationCard(
                context,
                icon: Icons.car_repair,
                title: 'Browse Services',
                subtitle: 'Explore available car services',
                route: const BrowseServicesRoute(),
              ),
        //       _buildNavigationCard(
        //         context,
        //         icon: Icons.book_online,
        //         title: 'Book a Service',
        //         subtitle: 'Schedule a service appointment',
        //         route: const BrowseServicesRoute(),
        //       ),
              _buildNavigationCard(
                context,
                icon: Icons.help,
                title: 'Help & Support',
                subtitle: 'Get assistance and support',
                route: const HelpSupportRoute(),
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