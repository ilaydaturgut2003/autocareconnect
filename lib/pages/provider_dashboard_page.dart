import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_route/auto_route.dart';
import '../router.gr.dart';

@RoutePage()
class ProviderDashboardPage extends StatelessWidget {
  const ProviderDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pushRoute(const LoginRoute());
      });
      return const Center(child: CircularProgressIndicator());
    }

    final userId = user.uid;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Application Status'),
              Tab(text: 'Home'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Application Status Tab
            ApplicationStatusScreen(userId: userId),

            // Provider Home Tab
            ProviderHomeScreen(userId: userId),
          ],
        ),
      ),
    );
  }
}

class ApplicationStatusScreen extends StatelessWidget {
  final String userId;

  const ApplicationStatusScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    if (userId.isEmpty) {
      return const Center(child: Text('Invalid user ID.'));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No application found.'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final role = data['role'] ?? 'applicant';

        if (role == 'applicant') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your application is under review.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Option to resubmit or update application
                  },
                  child: const Text('Update Application'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('You are already approved as a provider.'));
        }
      },
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
                    return ListTile(
                      title: Text(service['service_name'] ?? 'Unnamed Service'),
                      subtitle: Text('Cost: \$${service['cost'] ?? 0}'),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Service History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('appointments')
                  .where('provider_id', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No service history available.'));
                }

                final appointments = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text('Service: ${appointment['service_type']}'),
                      subtitle: Text('Status: ${appointment['status']}'),
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
