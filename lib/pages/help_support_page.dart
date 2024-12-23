import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../app_header.dart';

@RoutePage()
class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              const Text(
                'Contact Us:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Email: support@autocareconnect.com'),
              const SizedBox(height: 4),
              const Text('Phone: +1 (123) 456-7890'),
              const SizedBox(height: 16),

              const Text(
                'Frequently Asked Questions (FAQ):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ExpansionTile(
                title: const Text('How do I reset my password?'),
                children: const [
                  ListTile(
                    title: Text('To reset your password, click "Forgot Password" on the login screen.'),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('How do I contact support?'),
                children: const [
                  ListTile(
                    title: Text('You can reach support via email at support@autocareconnect.com or call +1 (123) 456-7890.'),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('How do I book a service?'),
                children: const [
                  ListTile(
                    title: Text('To book a service, browse services on the homepage and click "Book Now" to select a service and schedule it.'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                'Submit a Request or Feedback:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter your message...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your message has been sent.')),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
