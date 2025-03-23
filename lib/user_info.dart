import 'package:flutter/material.dart';
import 'package:lumistone/MainMenu.dart';
import 'package:lumistone/Profile.dart';

void main() {
  runApp(MyApp4());
}

class MyApp4 extends StatelessWidget {
  const MyApp4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResultInfoScreen(),
    );
  }
}

// Result Information Screen
class ResultInfoScreen extends StatefulWidget {
  const ResultInfoScreen({super.key});

  @override
  _ResultInfoScreenState createState() => _ResultInfoScreenState();
}

class _ResultInfoScreenState extends State<ResultInfoScreen> {
  String? _selectedZone;
  String? _selectedDepth;
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color.fromARGB(210, 255, 237, 246),
              const Color.fromARGB(210, 250, 199, 225),
              const Color.fromARGB(210, 249, 178, 215),
              const Color.fromARGB(229, 247, 132, 191),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Database',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(200, 0, 0, 0),
                      ),
                    ),
                    Icon(
                      Icons.storage,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 28,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Result Information Table,',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(179, 1, 1, 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/pic1.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      _buildInfoField('Scan ID'),
                      _buildInfoField('Data'),
                      _buildInfoField('Time'),
                      _buildRadioField(
                        'Zone',
                        ['A', 'B', 'C', 'D'],
                        _selectedZone,
                        (value) {
                          setState(() {
                            _selectedZone = value;
                          });
                        },
                      ),
                      _buildRadioField(
                        'Depth Scanned',
                        ['100m', '200m', '300m'],
                        _selectedDepth,
                        (value) {
                          setState(() {
                            _selectedDepth = value;
                          });
                        },
                      ),
                      _buildInfoField('Result'),
                      _buildRemarkField(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              print('Navigate to home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, size: 30, color: Colors.white),
            onPressed: () {
              // Navigate to profile
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp7()),
              );
              print('Navigate to profile');
            },
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4), // Transparent background
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Icon(Icons.more_horiz, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioField(String label, List<String> options,
      String? selectedValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4), // Transparent background
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options.map((option) {
                return Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selectedValue,
                      onChanged: onChanged,
                      activeColor: const Color.fromARGB(193, 244, 1, 179),
                    ),
                    Text(option, style: TextStyle(color: Colors.black)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemarkField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4), // Transparent background
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remark',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _remarkController,
              decoration: InputDecoration(
                hintText: 'Enter your remark here...',
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
