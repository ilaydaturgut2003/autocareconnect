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

  Future<void> _deleteService(String serviceId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('services').doc(serviceId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete service: $e')),
      );
    }
  }

  Future<void> _editService(String serviceId, BuildContext context) async {
    context.router.push(
      EditServiceRoute(serviceId: serviceId),
    );
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
                      .where('provider_id', isNotEqualTo: null)
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
                        final providerId = service['provider_id'];
                        final serviceId = services[index].id;

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection('users').doc(providerId).get(),
                          builder: (context, providerSnapshot) {
                            final providerName = (providerSnapshot.hasData && providerSnapshot.data?.data() != null)
                                ? (providerSnapshot.data!.data() as Map<String, dynamic>)['username'] ?? 'Unknown'
                                : 'Loading...';

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
                                        serviceId: serviceId,
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
                                    child: InkWell(
                                      onTap: () {
                                        context.pushRoute(ProfileRoute(
                                          providerId: providerId,
                                        ));
                                      },
                                      child: Text(
                                        'Posted by: $providerName',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (role == 'admin')
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          onPressed: () => _editService(serviceId, context),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => _deleteService(serviceId, context),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
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
