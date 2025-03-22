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
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gem_bg_new.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/gem_logo2.png'),
                        radius: screenWidth * 0.2, // Responsive logo size
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06, // Responsive font size
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
                      _buildTextField('Phone', _mobileController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone number';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid Phone number';
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
                        width: screenWidth * 0.6, // Responsive button width
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
                              fontSize:
                                  screenWidth * 0.08, // Responsive font size
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
      labelStyle:
          TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
      filled: true,
      fillColor:
          Colors.white.withOpacity(0.3), // Make background semi-transparent
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }
}
