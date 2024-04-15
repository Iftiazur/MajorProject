import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/class_details_screen.dart';
import 'package:path_provider/path_provider.dart';

class TakeAttendanceScreen extends StatefulWidget {
  @override
  _TakeAttendanceScreenState createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  List<List<dynamic>> classData = [];

  @override
  void initState() {
    super.initState();
    _readClassData();
  }

  Future<void> _readClassData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/class_data/class_data.csv');
      if (await file.exists()) {
        String csvContent = await file.readAsString();
        List<List<dynamic>> csvList = CsvToListConverter().convert(csvContent);

        // Filter out the default tile ('Class Name')
        csvList.removeWhere((classInfo) => classInfo[0] == 'Class Name');

        setState(() {
          classData = csvList;
        });
      }
    } catch (e) {
      print("Error reading CSV file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance'),
      ),
      body: ListView.builder(
        itemCount: classData.length,
        itemBuilder: (context, index) {
          List<dynamic> classInfo = classData[index];
          String className = classInfo[0];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ClassDetailsScreen(classInfo: classInfo),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  className,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
