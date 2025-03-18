import 'package:flutter/material.dart';

class ResultInfoScreen extends StatefulWidget {
  @override
  _ResultInfoScreenState createState() => _ResultInfoScreenState();
}

class _ResultInfoScreenState extends State<ResultInfoScreen> {
  String? _selectedZone;
  String? _selectedDepth;
  TextEditingController _remarkController = TextEditingController();

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 84, 166),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Database',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.storage,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'User Information Table,',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoField('User ID'),
              _buildInfoField('Full Name'),
              _buildInfoField('Email'),
              _buildInfoField('Phone Number'),
              _buildInfoField('Role'),
              _buildInfoField('Date of Registration'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 247, 250),
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
}
