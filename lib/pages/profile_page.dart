import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To access user info from Firebase
import 'package:autocareconnect/router.gr.dart';
import '../app_header.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Get the current user

    return Scaffold(
      appBar: const AppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header with User's Name and Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!) // Display user's photo if available
                    : const AssetImage('assets/default-avatar.png') as ImageProvider, // Default avatar if no photo
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                user?.displayName ?? 'User Name', // Display the user's name if available
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                user?.email ?? 'Email not available', // Display the email if available
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),

            // Profile Details Section
            Text(
              'Account Information:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(user?.email ?? 'No email provided'),
              ),
            ),
            // Add more user information sections as needed (phone number, address, etc.)

            const SizedBox(height: 32),

            // Action Buttons
            ElevatedButton(
              onPressed: () {
                // Action to edit profile, can navigate to another screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit Profile clicked')),
                );
              },
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Sign out the user
                context.router.push(LoginRoute()); // Navigate to login page
              },
              child: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16), 
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
