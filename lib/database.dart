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
      home: DatabaseScreen(),
    );
  }
}

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[300],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
          'Database',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.storage, size: 28),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Result Information Table,',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: SingleChildScrollView(
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.black, width: 1),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(5),
                    },
                    children: [
                      _buildTableRow('Scan ID', ''),
                      _buildTableRow('Date', ''),
                      _buildTableRow('Time', ''),
                      _buildTableRow('Zone', ''),
                      _buildTableRow('Depth Scanned', ''),
                      _buildTableRow('Result', ''),
                      _buildTableRow('Remark', ''),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.pink[400],
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(value),
        ),
      ],
    );
  }
}
