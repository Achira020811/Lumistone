import 'package:flutter/material.dart';
import 'package:lumistone/main_log.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String name;
  final String email;
  final String mobile;
  final String? imageUrl;

  User({
    required this.name, 
    required this.email, 
    required this.mobile,
    this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: FutureBuilder<User>(
          future: fetchUserData(),
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
                imageUrl: user.imageUrl,
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
  final String? imageUrl;

  const CommonPage({
    super.key,
    required this.title,
    required this.email,
    required this.mobile,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
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
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 182, 216),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      if (imageUrl != null && imageUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            imageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.account_circle, 
                                size: 80, 
                                color: Colors.black
                              );
                            },
                          ),
                        )
                      else
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
                    color: Colors.white.withOpacity(0.3),
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
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp1()),
                    ),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 30, color: Colors.white),
              onPressed: () {
                // Navigate to home
                print('Navigate to home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30, color: Colors.white),
              onPressed: () {
                // Navigate to profile
                print('Navigate to profile');
              },
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
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Future<User> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));
  return User(
    name: "JOHN SMITH", 
    email: "ABC123@gmail.com", 
    mobile: "+94xxxxxxxxxx",
    imageUrl: "https://your-database-image-url.com/profile.jpg",
  );
}