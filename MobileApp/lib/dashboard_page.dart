import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/assets.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Update time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6B06DA), // Blue color (hex: #0000FF)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: screenHeight * 0.04, // Adjusted size
                    backgroundImage: AssetImage(AppAssets.userImage),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Adjusted spacing
                  Text(
                    'Haradhan Chel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.025, // Adjusted font size
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Your Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Take Attendance'),
            ),
            ListTile(
              title: Text('Create Class'),
            ),
            ListTile(
              title: Text('Delete Class'),
            ),
          ],
        ),
      ),
      body: Center(
        // Center alignment
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.03), // Adjusted spacing
              CircleAvatar(
                radius: screenHeight * 0.1, // Adjusted size
                backgroundImage: AssetImage(AppAssets.userImage),
              ),
              SizedBox(height: screenHeight * 0.03), // Adjusted spacing
              Text(
                'Haradhan Chel',
                style: TextStyle(
                  fontSize: screenHeight * 0.053, // Adjusted font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ), // Adjusted spacing
              Text(
                'ID Number: 0001',
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // Adjusted font size
                  color: Color(0xFF012769),
                  fontStyle: FontStyle.italic, // Italic text
                ),
              ),
              Text(
                'Branch: ECE',
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // Adjusted font size
                  color: Color(0xFF012769), // Green color (hex: #00FF00)
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Adjusted spacing
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.now()), // Date
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // Adjusted font size
                  color: Color(0xFF0000FF), // Blue color (hex: #0000FF)
                ),
              ),
              Text(
                _currentTime, // Real-time Time
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // Adjusted font size
                  color: Color(0xFF0000FF), // Red color (hex: #FF0000)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
