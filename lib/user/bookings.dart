//import 'dart:js';

import 'package:flutter/material.dart';

class BookingsPage extends StatefulWidget {
  final String name;

  const BookingsPage({required this.name});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  
  void _showDatePicker(){
    showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2000), 
    lastDate: DateTime(2035));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Calendar and Booking Details for ${widget.name}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 16.0),
                Text(
                  'Select Date:',
                  style: TextStyle(fontSize: 16.0),
                ),
                ElevatedButton(
                  onPressed: () {_showDatePicker();
                    // TableCalendar(focusedDay: today, firstDay: firstDay, lastDay: lastDay)
                    // // Handle date selection
                  },
                  child: Text('Pick Date'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Select Time:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Slider(
                  value: 0.0,
                  min: 0.0,
                  max: 24.0,
                  divisions: 24,
                  onChanged: (value) {
                    // Handle time selection
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
