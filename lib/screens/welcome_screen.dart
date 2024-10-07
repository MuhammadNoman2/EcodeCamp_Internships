// screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'main_screen.dart'; // Import main screen

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer to navigate to the main screen after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Make the background fill the entire screen
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0], // Adjust stops to control color distribution
              ),
            ),
          ),
          // Content on top of the gradient
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check_circle_outline, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Welcome to Your To-Do List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text to stand out on the gradient
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
