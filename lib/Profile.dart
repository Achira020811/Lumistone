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
        child: FutureBuilder<User>(
          future: fetchUserData(), // Fetch user data from the database
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("No user data found"));
            } else {
              User user = snapshot.data!;
              return CommonPage(
                title: user.name,
                email: user.email,
                mobile: user.mobile,
              );
            }
          },
        ),
      ),
    );
  }
}

class CommonPage extends StatelessWidget {
  final String title;
  final String email;
  final String mobile;

  const CommonPage({super.key, 
    required this.title,
    required this.email,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 130, 167),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_circle, size: 80, color: Colors.black),
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60),

                // Information Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(70),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("EMAIL", email),
                      SizedBox(height: 45),
                      _buildInfoRow("MOBILE", mobile),
                    ],
                  ),
                ),

                Spacer(),

                // Log Out Button
                ElevatedButton(
                  onPressed: () {
                    // Log out action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),

            // Profile Icon at Bottom Right
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  // Navigate to Profile Screen
                },
                child: Icon(Icons.account_circle, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

// Mock user data fetching function
Future<User> fetchUserData() async {
  // Replace this with your actual database fetching logic
  await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  return User(name: "JOHN SMITH", email: "ABC123@gmail.com", mobile: "+94xxxxxxxxxx");
}

class User {
  final String name;
  final String email;
  final String mobile;

  User({required this.name, required this.email, required this.mobile});
}