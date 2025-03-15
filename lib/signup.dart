import 'package:flutter/material.dart';

void main() {
  runApp(LumistoneApp());
}

class LumistoneApp extends StatelessWidget {
  const LumistoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumistone',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient and image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 250, 219, 230),
                  const Color.fromARGB(255, 243, 182, 216),
                  const Color.fromARGB(255, 179, 123, 154),
                  const Color.fromARGB(255, 146, 73, 114),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    CircleAvatar(
                      backgroundImage: AssetImage('images/gem_logo.png'),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Username Field
                    _buildTextField('USERNAME...'),
                    SizedBox(height: 5),
                    // Mobile Field
                    _buildTextField('MOBILE'),
                    SizedBox(height: 5),
                    // Email Field
                    _buildTextField('EMAIL'),
                    SizedBox(height: 5),
                    // Password Field
                    _buildTextField('PASSWORD', obscureText: true),
                    SizedBox(height: 5),
                    // Confirm Password Field
                    _buildTextField('CONFIRM PASSWORD', obscureText: true),
                    SizedBox(height: 40),
                    // Sign-Up Button
                    SizedBox(
                      width: 200, // Reduced button width
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to Lumistone!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
