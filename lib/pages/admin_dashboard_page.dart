import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';
import '../router.gr.dart';
import '../router.dart';
import '../app_header.dart'; 

@RoutePage()
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  Future<void> _updateApplicationStatus(String userId, String newRole, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'role': newRole});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User role updated to $newRole successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user role: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'applicant').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending applications.'));
          }

          final applicants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applicants.length,
            itemBuilder: (context, index) {
              final applicant = applicants[index].data() as Map<String, dynamic>;
              final userId = applicants[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(applicant['username'] ?? 'Unnamed User'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${applicant['email'] ?? 'No email provided'}'),
                      Text('Role: ${applicant['role']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => _updateApplicationStatus(userId, 'provider', context),
                        child: const Text('Approve'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _updateApplicationStatus(userId, 'user', context),
                        child: const Text('Reject'),
                      ),
                    ],
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
