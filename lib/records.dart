import 'package:flutter/material.dart';
import 'package:lumistone/MainMenu.dart';
import 'package:lumistone/Profile.dart';
import 'package:lumistone/database%20copy.dart';
import 'package:lumistone/gem_database.dart';
import 'package:lumistone/gold_database.dart';
import 'package:lumistone/user_info.dart';

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
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Opacity
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              'assets/records_new.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 250, 219, 230).withOpacity(0.9),
                  const Color.fromARGB(255, 243, 182, 216).withOpacity(0.8),
                  const Color.fromARGB(255, 179, 123, 154).withOpacity(0.8),
                  const Color.fromARGB(255, 146, 73, 114).withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
                  child: Text(
                    'Records',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                        vertical: screenSize.height * 0.02,
                      ),
                      child: GridView.count(
                        crossAxisCount: 2, // Always 2 columns
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: screenSize.height * 0.03,
                        crossAxisSpacing: screenSize.width * 0.03,
                        childAspectRatio: isSmallScreen ? 1.2 : 1.5,
                        children: [
                          InformationCard(
                            title: 'User Information Table',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      MyApp3(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          InformationCard(
                            title: 'Water Information Table',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const MyApp4(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          InformationCard(
                            title: 'Gold Information Table',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const MyApp5(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
                            },
                          ),
                          InformationCard(
                            title: 'Gem Information Table',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const MyApp6(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
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
        ],
      ),
      bottomNavigationBar: Container(
        height: screenSize.height * 0.08,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  [
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
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

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
          borderRadius: BorderRadius.circular(screenSize.width * 0.02),
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
        transform:
            isPressed ? (Matrix4.identity()..scale(0.95)) : Matrix4.identity(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 18,
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
