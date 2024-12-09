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
             title: Text(carList[index].name), // Display car name
              subtitle: Text('Price: \$${carList[index].price.toString()}'), // Display car price
              leading: Icon(Icons.directions_car), // Icon for each item
              onTap: () {
                // Handle tap event
              },
            ),
          );
        },
      ),
    );
  }
}
            },
            child: Text('Browse Services'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
             if (value == null || value.isEmpty) {
                    return 'Please enter your car model';
                  }
                  return null;
                },
                onSaved: (value) {
                  _carModel = value!;
                },
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text("Select Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text("Select Time: ${_selectedTime.format(context)}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickTime,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
            },
            child: Text('Book a Service'),
          ),
        ],
      ),
    );
  }
}
