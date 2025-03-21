import 'package:flutter/material.dart';
import 'package:lumistone/Profile.dart';
import 'package:lumistone/GemDetection.dart';
import 'package:lumistone/WaterLevel.dart';
import 'package:lumistone/location%20page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  List<bool> _isHovered = List.generate(5, (_) => false);
  List<bool> _isPressed = List.generate(5, (_) => false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(int index, bool isHovered) {
    setState(() {
      _isHovered[index] = isHovered;
    });
  }

  void _handlePress(int index, bool isPressed) {
    setState(() {
      _isPressed[index] = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.pink.shade100,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return GridView.count(
                          crossAxisCount: 2,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: [
                            _buildAnimatedMenuItem(
                              "Water Detection",
                              "assets/Water Drop.png",
                              85.0,
                              85.0,
                              const WaterDetectionScreen(),
                              0,
                            ),
                            _buildAnimatedMenuItem(
                              "Records",
                              "assets/database.png",
                              70.0,
                              70.0,
                              const RecordsScreen(),
                              1,
                            ),
                            _buildAnimatedMenuItem(
                              "Gem Detection",
                              "assets/gem.png",
                              70.0,
                              70.0,
                              const GemDetectionScreen(),
                              2,
                            ),
                            _buildAnimatedMenuItem(
                              "Notification",
                              "assets/notification-bell.png",
                              65.0,
                              65.0,
                              const NotificationScreen(),
                              3,
                            ),
                            _buildAnimatedMenuItem(
                              "Gold Detection",
                              "assets/Gold Detection.png",
                              75.0,
                              75.0,
                              const NotificationScreen(),
                              4,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _buildBottomProfileIcon(),
                ],
              ),
            ),
            _buildProfileButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: const Text(
            "LUMISTONE",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 158, 30, 117),
            ),
          ),
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: const [
              SizedBox(height: 10),
              Text(
                "Welcome User,",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedMenuItem(
    String title,
    String imagePath,
    double imageWidth,
    double imageHeight,
    Widget destinationScreen,
    int index,
  ) {
    bool isHovered = _isHovered[index];
    bool isPressed = _isPressed[index];

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 + (index * 0.1),
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: MouseRegion(
        onEnter: (_) => _handleHover(index, true),
        onExit: (_) => _handleHover(index, false),
        child: GestureDetector(
          onTapDown: (_) => _handlePress(index, true),
          onTapUp: (_) {
            _handlePress(index, false);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    destinationScreen,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          onTapCancel: () => _handlePress(index, false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()
              ..scale(isPressed ? 0.95 : isHovered ? 1.08 : 1.0)
              ..translate(0.0, isHovered ? -8.0 : 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: isPressed
                    ? Colors.pink.shade300
                    : isHovered
                        ? Colors.pink.shade200
                        : Colors.pink.shade100,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                        isPressed ? 0.3 : isHovered ? 0.25 : 0.1),
                    blurRadius: isPressed ? 24 : isHovered ? 16 : 8,
                    offset:
                        Offset(0, isPressed ? 2 : isHovered ? 8 : 4),
                    spreadRadius: isPressed ? 1 : isHovered ? 4 : 2,
                  ),
                ],
                border: Border.all(
                  color: isPressed
                      ? Colors.pink.shade400
                      : isHovered
                          ? Colors.pink.shade300.withOpacity(0.5)
                          : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    transform: Matrix4.identity()
                      ..scale(isPressed ? 0.9 : isHovered ? 1.15 : 1.0),
                    child: Image.asset(
                      imagePath,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isPressed ? 20 : isHovered ? 18 : 16,
                      color: isPressed
                          ? Colors.black
                          : isHovered
                              ? Colors.black.withOpacity(0.9)
                              : Colors.black54,
                    ),
                    child: Text(title),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomProfileIcon() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade100, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    return Positioned(
      bottom: 3.0,
      right: 16.0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: IconButton(
          icon: const Icon(Icons.account_circle, size: 40, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CommonPage(
                  title: 'User Profile',
                  email: 'user@example.com',
                  mobile: '123-456-7890',
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Screen classes remain the same
class WaterDetectionScreen extends StatelessWidget {
  const WaterDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) => const LocationPage();
}

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) => const WaterLevelDetectionPage();
}

class GemDetectionScreen extends StatelessWidget {
  const GemDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) => const GemDepthSelectionPage();
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: const Center(child: Text("Notification Screen")),
    );
  }
}