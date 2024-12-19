import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_header.dart';

@RoutePage()
class ServiceDetailsPage extends StatelessWidget {
  final String serviceId;

  const ServiceDetailsPage({super.key, required this.serviceId});

  Future<bool> _isUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return userDoc.exists && userDoc.data()?['role'] == 'user';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text('Please log in to view service details.'),
      );
    }

    return Scaffold(
      appBar: const AppHeader(),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('services').doc(serviceId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Service not found.'));
          }

          final service = snapshot.data!.data() as Map<String, dynamic>;

          return FutureBuilder<bool>(
            future: _isUser(),
            builder: (context, userRoleSnapshot) {
              if (userRoleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final isUser = userRoleSnapshot.data ?? false;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['service_name'] ?? 'Unnamed Service',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Cost: \$${service['cost'] ?? 0}'),
                    const SizedBox(height: 16),
                    Text(service['description'] ?? 'No description available.'),
                    const Spacer(),
                    if (isUser)
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection('bookings').add({
                            'user_id': user.uid,
                            'service_id': serviceId,
                            'service_name': service['service_name'],
                            'status': 'pending',
                            'booking_date': DateTime.now(),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Service booked successfully!')),
                          );

                          Navigator.of(context).pop();
                        },
                        child: const Text('Book Service'),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
