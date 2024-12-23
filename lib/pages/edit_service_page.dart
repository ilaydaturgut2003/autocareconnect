import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_header.dart';
import '../router.gr.dart';

@RoutePage()
class EditServicePage extends StatefulWidget {
  final String serviceId;

  const EditServicePage({super.key, required this.serviceId});

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _serviceNameController;
  late TextEditingController _costController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  Future<void> _loadServiceData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('services').doc(widget.serviceId).get();
      final data = doc.data() as Map<String, dynamic>;

      _serviceNameController = TextEditingController(text: data['service_name']);
      _costController = TextEditingController(text: data['cost'].toString());
      _locationController = TextEditingController(text: data['location']);
      _descriptionController = TextEditingController(text: data['description']);

      setState(() {
        _isLoading = false; 
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load service data: $e'),
      ));
      Navigator.pop(context); 
    }
  }

  Future<void> _updateService() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('services').doc(widget.serviceId).update({
          'service_name': _serviceNameController.text,
          'cost': double.parse(_costController.text),
          'location': _locationController.text,
          'description': _descriptionController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Service updated successfully!'),
        ));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update service: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), 
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _serviceNameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a service name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty || double.tryParse(value) == null ? 'Please enter a valid cost' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateService,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
