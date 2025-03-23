import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lumistone/MainMenu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lumistone/Profile.dart';

void main() {
  runApp(const WaterDetectionApp());
}

class WaterDetectionApp extends StatelessWidget {
  const WaterDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterDetectionScreen(),
    );
  }
}

class WaterDetectionScreen extends StatefulWidget {
  const WaterDetectionScreen({super.key});

  @override
  _WaterDetectionScreenState createState() => _WaterDetectionScreenState();
}

class _WaterDetectionScreenState extends State<WaterDetectionScreen> {
  String waterDepth = ""; // Variable to hold backend value

  @override
  void initState() {
    super.initState();
    _fetchWaterDepth();
  }

  Future<void> _fetchWaterDepth() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/constant_depth/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        waterDepth = data['depth'];
      });
    } else {
      print('Failed to fetch water depth: ${response.statusCode}');
      setState(() {
        waterDepth = "Error"; // Display an error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/background_water.jpg',
            fit: BoxFit.cover,
          ),
          // UI Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Scan finished\nWater detected",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              // Animated Checkmark Icon
              BounceInDown(
                child: Image.asset(
                  'assets/checkmark.png',
                  width: 200,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Water Found Depth",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    waterDepth,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildExitButton(context, "Exit",
                      const Color.fromARGB(255, 245, 234, 238)),
                  const SizedBox(width: 50),
                  _buildButton(context, "Continue",
                      const Color.fromARGB(255, 245, 234, 238)),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          IconButton(
            icon: const Icon(Icons.home, size: 30, color: Colors.white),
            onPressed: () {
              // Navigate to home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              print('Navigate to home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, size: 30, color: Colors.white),
            onPressed: () {
              // Navigate to profile
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp7()),
              );
              print('Navigate to profile');
            },
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildExitButton(BuildContext context, String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()), // Navigates to Home Page
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return BounceInUp(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                title: Text("$text Button Pressed"),
                content: const Text("You have clicked on a button."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}