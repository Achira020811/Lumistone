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
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 250, 219, 230),
        Color.fromARGB(255, 243, 182, 216),
        Color.fromARGB(255, 179, 123, 154),
        Color.fromARGB(255, 146, 73, 114),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 50, top: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 40,
                      children: [
                        InformationCard(
                          title: 'User Information Table',
                          onTap: () {
                            print('Navigate to user information table');
                          },
                        ),
                        InformationCard(
                          title: 'Result Information Table',
                          onTap: () {
                            print('Navigate to result information table');
                          },
                        ),
                        InformationCard(
                          title: 'Activity Information Table',
                          onTap: () {
                            print('Navigate to activity information table');
                          },
                        ),
                        InformationCard(
                          title: 'Settings Information Table',
                          onTap: () {
                            print('Navigate to settings information table');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Container(
          height: 60,
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, size: 30, color: Colors.white),
                onPressed: () {
                  print('Navigate to home');
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, size: 30, color: Colors.white),
                onPressed: () {
                  print('Navigate to profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const InformationCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isPressed 
              ? Colors.white.withOpacity(0.5) 
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        transform: isPressed 
            ? (Matrix4.identity()..scale(0.95))
            : Matrix4.identity(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isPressed ? Colors.black87 : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}