import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_route/auto_route.dart';
import '../app_header.dart';
import '../router.gr.dart';
import '../router.dart';

@RoutePage()
class ProviderDashboardPage extends StatelessWidget {
  final String userId;

  const ProviderDashboardPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Account History'),
                Tab(text: 'Service History'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProviderHomeScreen(userId: userId),
                  ProviderAccountHistoryScreen(userId: userId),
                  ProviderServiceHistoryScreen(userId: userId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderHomeScreen extends StatelessWidget {
  final String userId;

  const ProviderHomeScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    if (userId.isEmpty) {
      return const Center(child: Text('Invalid user ID.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              context.router.push(const PostServiceRoute());
            },
            child: const Text('Create a New Service'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Summary of Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('services')
                  .where('provider_id', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No services available.'));
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProviderAccountHistoryScreen extends StatelessWidget {
  final String userId;

  const ProviderAccountHistoryScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Account History for $userId'),
    );
  }
}

class ProviderServiceHistoryScreen extends StatelessWidget {
  final String userId;

  const ProviderServiceHistoryScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Service History for $userId'),
    );
  }
}
