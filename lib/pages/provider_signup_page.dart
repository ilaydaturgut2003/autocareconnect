import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProviderSignupPage extends StatelessWidget {
  const ProviderSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text('Please log in to apply as a provider.'),
      );
    }

    final userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Sign-Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProviderSignupForm(userId: userId),
      ),
    );
  }
}

class ProviderSignupForm extends StatelessWidget {
  final String userId;

  const ProviderSignupForm({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _servicesController = TextEditingController();

    Future<void> _submitApplication() async {
      if (_formKey.currentState!.validate()) {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': _nameController.text,
          'proposed_services': _servicesController.text,
          'role': 'applicant',
          'submitted_at': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')),
        );

        Navigator.pop(context);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Apply to Become a Provider',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _servicesController,
            decoration: const InputDecoration(
              labelText: 'Services Offered',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe the services you offer';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitApplication,
            child: const Text('Submit Application'),
          ),
        ],
      ),
    );
  }
}
