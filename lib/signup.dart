import 'package:flutter/material.dart';
import 'package:lumistone/MainMenu.dart';

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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/gem_logo2.png'),
                        radius: 80,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: 50),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Username Field
                      _buildTextField('Username', _usernameController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      }),
                      SizedBox(height: 5),
                      // Mobile Field
                      _buildTextField('Mobile', _mobileController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      }),
                      SizedBox(height: 5),
                      // Email Field
                      _buildTextField('Email', _emailController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      }),
                      SizedBox(height: 5),
                      // Password Field
                      _buildPasswordField(
                          'Password', _passwordController, _obscurePassword,
                          () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      }),
                      SizedBox(height: 5),
                      // Confirm Password Field
                      _buildPasswordField(
                          'Confirm Password',
                          _confirmPasswordController,
                          _obscureConfirmPassword, () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      }),
                      SizedBox(height: 40),
                      // Sign-Up Button
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
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
          ),
        ],
      ),
    );
  }

  /// Builds a stylized text field with the given label and validator
  Widget _buildTextField(String label, TextEditingController controller,
      String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(label),
      validator: validator,
    );
  }

  /// Builds a stylized password field with a toggle for visibility
  Widget _buildPasswordField(String label, TextEditingController controller,
      bool obscureText, VoidCallback toggleObscure) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: _buildInputDecoration(label).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: toggleObscure,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  /// Defines a consistent input field decoration
  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black, fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255), width: 1.5),
      ),
    );
  }
}
