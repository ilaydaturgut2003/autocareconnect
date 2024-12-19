import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocareconnect/router.gr.dart';
import '../app_header.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;
  bool _needsUsername = false;
  String? _username;

  @override
  void initState() {
    super.initState();
    _checkUsername();
  }

  Future<void> _checkUsername() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    setState(() {
      _isLoading = false;
      _needsUsername = !(userDoc.exists && userDoc.data()!['username'] != null);
      _username = userDoc.data()?['username'];
    });
  }

  Future<void> _saveUsername(String username) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({
      'username': username,
    });

    setState(() {
      _needsUsername = false;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _needsUsername
            ? _buildUsernamePrompt()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const AssetImage('assets/default-avatar.png')
                              as ImageProvider,
                      backgroundColor: Colors.blueAccent,
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
                      user?.email ?? 'Email not available',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Account Information
                  const Text(
                    'Account Information:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(user?.email ?? 'No email provided'),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit Profile clicked')),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _auth.signOut();
                      context.router.push(const LoginRoute());
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

  Widget _buildUsernamePrompt() {
    final _usernameController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Welcome!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Please set a username to continue.'),
        const SizedBox(height: 16),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final username = _usernameController.text.trim();
            if (username.isNotEmpty) {
              _saveUsername(username);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Username cannot be empty.')),
              );
            }
          },
          child: const Text('Save Username'),
        ),
      ],
    );
  }
}
