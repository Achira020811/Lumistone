import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lumistone/FrontPage2.dart';


import 'package:lumistone/MainMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: SplashScreen(),
        nextScreen: Screen1(),
        splashIconSize: double.infinity,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: GradientBackgroundScreen(),
        nextScreen: HomePage(),
        splashIconSize: double.infinity,
        duration: 3000,
        splashTransition: SplashTransition.scaleTransition,animationDuration:Duration(milliseconds: 1000),  
        backgroundColor: Colors.black,
      ),
    );

    
  }
}


class GradientBackgroundScreen extends StatelessWidget {
  const GradientBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink.shade100,
                Color.fromARGB(
                    255, 111, 25, 74) // Bottom color (purplish gradient)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Logo Crop.png",
                  height: 150,
                ),
        
                // Add your content like the logo and text here
                // CircleAvatar(
                //   backgroundColor: Colors.black,
                //   radius: 60,
                //   child: Icon(
                //     Icons.diamond,
                //     color: Colors.pinkAccent,
                //     size: 60,
                //   ),
                // ),
                // SizedBox(height: 20),
                // Text(
                //   'LUMISTONE',
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(height: 10),
                Text(
                  'AI Powered ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' Gem Detector System',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
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
