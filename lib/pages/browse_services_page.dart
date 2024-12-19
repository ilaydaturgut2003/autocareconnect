import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_header.dart';
import '../router.gr.dart';

@RoutePage()
class BrowseServicesPage extends StatelessWidget {
  const BrowseServicesPage({super.key});

  Future<String> _getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'guest';
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>?;
      return data?['role'] ?? 'user';
    }
    return 'user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: FutureBuilder<String>(
        future: _getUserRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final role = snapshot.data ?? 'user';

          return Column(
            children: [
              if (role == 'provider')
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const PostServiceRoute());
                    },
                    child: const Text('Post a Service'),
                  ),
                ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('services')
                      .where('provider_id', isNotEqualTo: null) // Ensures services are posted by providers
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  service['service_name'] ?? 'Unnamed Service',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Cost: \$${service['cost'] ?? 0}\n'
                                  'Location: ${service['location'] ?? 'Not provided'}',
                                ),
                                onTap: () {
                                  context.pushRoute(ServiceDetailsRoute(
                                    serviceId: services[index].id,
                                  ));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  service['description'] ?? 'No description available.',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Posted by: ${service['provider_name'] ?? 'Unknown'}',
                                  style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    final serviceId = services[index].id;
                                    final serviceName = service['service_name'] ?? 'Unnamed Service';
                                    final cost = service['cost'] ?? 0.0;

                                    context.pushRoute(BookingRoute(
                                      serviceId: serviceId,
                                      serviceName: serviceName,
                                      cost: cost,
                                    ));
                                  },
                                  child: const Text('Book This Service'),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
