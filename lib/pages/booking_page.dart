import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_header.dart';
import '../router.gr.dart';

@RoutePage()
class BookingPage extends StatelessWidget {
  final String serviceId;
  final String serviceName;
  final double cost;

  const BookingPage({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.cost,
  });

  Future<void> _bookService(BuildContext context) async {
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
        'service_id': serviceId,
        'service_name': serviceName,
        'status': 'pending',
        'booking_date': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully booked $serviceName!')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service: $serviceName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Cost: \$${cost.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _bookService(context),
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
