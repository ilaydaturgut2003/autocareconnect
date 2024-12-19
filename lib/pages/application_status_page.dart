import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_route/auto_route.dart';
import '../router.gr.dart';

@RoutePage()
class ApplicationStatusPage extends StatelessWidget {
  const ApplicationStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text('Please log in to view your application status.'),
      );
    }

    final userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Status'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/provider_signup');
                },
                child: const Text('Apply Now'),
              ),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final role = data['role'] ?? 'applicant';

          if (role == 'applicant') {
            return const Center(
              child: Text('Your application is under review.'),
            );
          } else if (role == 'provider') {
            return const Center(
              child: Text('Your application has been approved!'),
            );
          } else if (role == 'user') {
            return const Center(
              child: Text('You are currently a regular user.'),
            );
          } else {
            return const Center(
              child: Text('Unknown application status.'),
            );
          }
        },
      ),
    );
  }
}
