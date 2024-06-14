import 'package:flutter/material.dart';
import 'package:trial/camera.dart';

class ClassDetailsScreen extends StatelessWidget {
  final List<dynamic> classInfo;

  const ClassDetailsScreen({required this.classInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align all widgets center
          mainAxisAlignment:
              MainAxisAlignment.center, // Align all widgets center
          children: [
            Text(
              'Class Name: ${classInfo[0]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 10), // Add spacing between widgets
            Text(
              'Course Code: ${classInfo[1]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 10), // Add spacing between widgets
            Text(
              'Branch: ${classInfo[2]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 10), // Add spacing between widgets
            Text(
              'Degree/Diploma: ${classInfo[3]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 10), // Add spacing between widgets
            Text(
              'Semester: ${classInfo[4]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 10), // Add spacing between widgets
            Text(
              'Total Students: ${classInfo[5]}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue), // Updated TextStyle
            ),
            SizedBox(height: 20), // Add larger spacing before the button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Increase button size
                child: Text(
                  'Camera',
                  style: TextStyle(fontSize: 24), // Increase font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
