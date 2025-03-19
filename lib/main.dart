import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:lumistone/FrontPage2.dart';
import 'package:lumistone/main_log.dart';

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
        splash: GradientBackgroundScreen(),
        nextScreen:MyApp1(),
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
        nextScreen: MyApp1(),
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
            image: DecorationImage(
              image: AssetImage("assets/Background image.jpg"), 
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/gem_logo2.png",
                    height: 350,
                  ),
                ),
                SizedBox(height: 10),
                // Text(
                //   'AI Powered ',
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.black,
                //   ),
                // ),
                // Text(
                //   ' Gem Detector System',
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}