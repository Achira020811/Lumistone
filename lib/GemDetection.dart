import 'package:flutter/material.dart';
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
      home: GemDepthSelectionPage(),
    );
  }
}

class GemDepthSelectionPage extends StatefulWidget {
  const GemDepthSelectionPage({super.key});

  @override
  _DepthSelectionPageState createState() => _DepthSelectionPageState();
}

class _DepthSelectionPageState extends State<GemDepthSelectionPage> {
  String selectedDepth = "None"; // Stores selected depth
  String userIcon = "default"; // User status from database (simulated)

  // Simulated function to get user status from a database
  void fetchUserData() {
    // Example: Fetch from Firestore or API (hardcoded for now)
    setState(() {
      userIcon = "active"; // Change based on actual DB data
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when screen loads
  }

  void selectDepth(String depth) {
    setState(() {
      selectedDepth = depth;
    });

    // Perform actions based on depth selection (e.g., fetch scan results)
    print("User selected depth: $depth");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
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
              ),
              Column(
                children: [
                  SizedBox(height: 50),
          
                  // Title
                  Text(
                    "Choose how deep to scan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // Responsive text
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          
                  Text(
                    "(Gem)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
          
                  SizedBox(height: screenWidth * 0.1),
          
                  // Depth Selection Buttons
                  _buildDepthButton(context, "1m"),
                  SizedBox(height: screenWidth * 0.07),
                  _buildDepthButton(context, "2m"),
                  SizedBox(height: screenWidth * 0.07),
                  _buildDepthButton(context, "3m"),
          
                  Spacer(),
          
                  // Selected Depth Text
                  Spacer(),
          
                  // Selected Depth Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        "Selected Depth: $selectedDepth",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          
                  SizedBox(height: 20),
                ],
              ),
          
              // Profile Icon at Bottom Right
              Positioned(
                bottom: 10,
                right: 30,
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
                  },
                  child: Icon(
                    // userIcon == "active"
                    //     ? Icons.verified_user
                    //     : 
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
    );
  }

  Widget _buildDepthButton(BuildContext context, String label) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => selectDepth(label),
      child: Container(
        width: screenWidth * 0.25,
        height: screenWidth * 0.25,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 213, 71, 118),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
