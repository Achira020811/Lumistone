import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset('assets/IMG_1203.png',
            height: double.infinity,
            width: double.infinity,fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
