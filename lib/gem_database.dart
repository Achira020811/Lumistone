import 'package:flutter/material.dart';

class ResultInfoScreen extends StatefulWidget {
  @override
  _ResultInfoScreenState createState() => _ResultInfoScreenState();
}

class _ResultInfoScreenState extends State<ResultInfoScreen> {
  String? _selectedZone;
  String? _selectedDepth;
  TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 84, 166),
      body: SafeArea(
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Result Information Table',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'lib/assets/Gem_Database.png',
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
                        'Zone', ['A', 'B', 'C', 'D'], _selectedZone, (value) {
                      setState(() {
                        _selectedZone = value;
                      });
                    }),
                    _buildRadioField('Depth Scanned', ['100m', '200m', '300m'],
                        _selectedDepth, (value) {
                      setState(() {
                        _selectedDepth = value;
                      });
                    }),
                    _buildInfoField('Result'),
                    _buildRemarkField(),
                  ],
                ),
              ),
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
          color: Colors.white,
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
          color: Colors.white,
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
                      activeColor: Colors.purple,
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
          color: Colors.white,
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
