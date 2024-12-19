import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_header.dart';
import '../router.gr.dart';

@RoutePage()
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  Future<void> _bookService(BuildContext context, Map<String, dynamic> service) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to book a service.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'user_id': user.uid,
        'service_id': service['service_id'],
        'service_name': service['service_name'],
        'status': 'pending',
        'booking_date': DateTime.now(),
        'provider_id': service['provider_id'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully booked ${service['service_name']}!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book service: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No services available for booking.'));
          }

          final services = snapshot.data!.docs;

          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(service['service_name'] ?? 'Unnamed Service'),
                  subtitle: Text('Cost: \$${service['cost'] ?? 0}'),
                  trailing: ElevatedButton(
                    onPressed: () => _bookService(context, service),
                    child: const Text('Book'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
