import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocareconnect/router.gr.dart';
import '../app_header.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final String providerId;
  
  const ProfilePage({super.key, required this.providerId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;
  String? _username;
  String? _email;
  String? _role;
  Timestamp? _createdAt;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    setState(() {
      _isLoading = false;
      _username = userDoc.data()?['username'];
      _email = user.email;
      _role = userDoc.data()?['role'];
      _createdAt = userDoc.data()?['createdAt'];
    });
  }

  Future<void> _saveUsername(String username) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({'username': username});

    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const AssetImage('assets/default-avatar.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _username ?? 'User Name',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _email ?? 'Email not available',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Account Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text('Username: ${_username ?? 'Not set'}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditUsernameDialog(context),
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text('Email: ${_email ?? 'Not available'}'),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.group),
                title: Text('Role: ${_role ?? 'Not available'}'),
              ),
            ),
            if (_createdAt != null)
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text('Account Created: ${_createdAt!.toDate()}'),
                ),
              ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                context.router.replace(const LoginRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditUsernameDialog(BuildContext context) {
    final _usernameController = TextEditingController(text: _username);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newUsername = _usernameController.text.trim();
              if (newUsername.isNotEmpty) {
                _saveUsername(newUsername);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Username cannot be empty.')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
