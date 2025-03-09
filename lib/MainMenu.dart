import 'package:flutter/material.dart';
import 'package:lumistone/Profile.dart';
import 'package:lumistone/WaterDetection.dart';
import 'package:lumistone/GemDetection.dart';
import 'package:lumistone/WaterLevel.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  SizedBox(height: 20),
                  Text(
                    "LUMISTONE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 158, 30, 117),
                    ),
                  ),
                SizedBox(height: 10),
                Text(
                  "Welcome User,",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      _buildMenuItem(
                        context,
                        "Water Detection",
                        Icons.water_drop,
                        Colors.blue,
                        WaterDetectionScreen(),
                      ),
                      _buildMenuItem(
                        context,
                        "Records",
                        Icons.storage,
                        Colors.orange,
                        RecordsScreen(),
                      ),
                      _buildMenuItem(
                        context,
                        "Gem Detection",
                        Icons.diamond,
                        Colors.black,
                        GemDetectionScreen(),
                      ),
                      _buildMenuItem(
                        context,
                        "Notification",
                        Icons.chat_bubble,
                        Colors.green,
                        NotificationScreen(),
                      ),
                    ],
                  ),
                ),
                _buildBottomProfileIcon(),
              ],
            ),
          ),
          Positioned(
            
              bottom: 3.0,
              right: 16.0,
              child: IconButton(
                icon: Icon(Icons.account_circle,size: 40, color:Colors.white),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonPage(
                    title: 'User Profile',
                    email: 'user@example.com',
                    mobile: '123-456-7890',
                  )),
                );
                },
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget destinationScreen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
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
}

// Dummy pages for navigation
class WaterDetectionScreen extends StatelessWidget {
  const WaterDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instead of showing a basic screen, we'll return the DepthSelectionPage
    return  WaterDepthSelectionPage();
  }
}

// Add these imports at the top of your first file (main.dart):


class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

   @override
   Widget build(BuildContext context) {
     // Instead of showing a basic screen, we'll return the DepthSelectionPage
    return  WaterLevelDetectionPage();
  }
}

class GemDetectionScreen extends StatelessWidget {
  const GemDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
     // Instead of showing a basic screen, we'll return the DepthSelectionPage
    return  GemDepthSelectionPage();
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(child: Text("Notification Screen")),
    );
  }
}
