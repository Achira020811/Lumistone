import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Records App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: const RecordsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 246, 223, 231),
              Colors.pink.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'Records',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // User Information Table
                      InformationCard(
                        title: 'User Information Table',
                        onTap: () {
                          // Navigate to user information table
                          print('Navigate to user information table');
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Result Information Table
                      InformationCard(
                        title: 'Result Information Table',
                        onTap: () {
                          // Navigate to result information table
                          print('Navigate to result information table');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom Navigation Bar
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, size: 30),
                      onPressed: () {
                        // Navigate to home
                        print('Navigate to home');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, size: 30),
                      onPressed: () {
                        // Navigate to profile
                        print('Navigate to profile');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const InformationCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}