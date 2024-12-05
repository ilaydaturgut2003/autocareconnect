import 'package:flutter/material.dart';

void main() => runApp(CarServiceApp());

class CarServiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoCorrect',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Service'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to browsing screen
            },
            child: Text('Browse Services'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to booking screen
            },
            child: Text('Book a Service'),
          ),
        ],
      ),
    );
  }
}
