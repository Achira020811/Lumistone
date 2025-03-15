import 'package:flutter/material.dart';
import 'package:lumistone/MainMenu.dart';
import 'package:lumistone/Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaterLevelDetectionPage(),
    );
  }
}

class WaterLevelDetectionPage extends StatelessWidget {
  const WaterLevelDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [Container(
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
              ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenWidth * 0.2),
                            
                      // Title
                      Text(
                        "Water Level Detection",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                            
                      Spacer(),
                            
                      // Exit Button
                      Padding(
                        padding: EdgeInsets.only(bottom: screenWidth * 0.1),
                        child: ElevatedButton(
                          onPressed: () {
                             Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 30,
                            ),
                          ),
                          child: Text(
                            "Exit",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                // Profile Icon at Bottom Right
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonPage(
                    title: 'User Profile',
                    email: 'user@example.com',
                    mobile: '123-456-7890',
                  )),
                );
                      // Navigate to Profile Screen
                    },
                    child: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
