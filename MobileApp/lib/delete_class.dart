import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DeleteClassScreen extends StatefulWidget {
  @override
  _DeleteClassScreenState createState() => _DeleteClassScreenState();
}

class _DeleteClassScreenState extends State<DeleteClassScreen> {
  List<List<dynamic>> classData = [];
  int _selectedItemIndex = -1;

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

        // Remove the default tile ('Class Name') and other default classes from the list
        csvList.removeWhere((classInfo) =>
            classInfo[0] == 'Class Name' || _isDefaultClass(classInfo));

        setState(() {
          classData = csvList;
        });
      }
    } catch (e) {
      print("Error reading CSV file: $e");
    }
  }

  bool _isDefaultClass(List<dynamic> classInfo) {
    // Check if the class name starts with "Default" or any other condition that identifies it as a default class
    return classInfo[0].toString().startsWith('Default');
  }

  Future<void> _deleteClass(int index) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/class_data/class_data.csv');
      if (await file.exists()) {
        String csvContent = await file.readAsString();
        List<List<dynamic>> csvList = CsvToListConverter().convert(csvContent);

        // Remove the class data at the specified index
        csvList.removeAt(index);

        // Write the updated CSV data back to the file
        await file.writeAsString(const ListToCsvConverter().convert(csvList));

        // Update the UI to reflect the changes
        setState(() {
          classData = csvList;
        });

        // Navigate back to the previous screen with updated data
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error deleting class: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Class'),
      ),
      body: ListView.builder(
        itemCount: classData.length,
        itemBuilder: (context, index) {
          List<dynamic> classInfo = classData[index];
          String className = classInfo[0];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                className,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _selectedItemIndex =
                      index; // Store the index of the selected item
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Class'),
                      content:
                          Text('Are you sure you want to delete this class?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _selectedItemIndex =
                                -1; // Reset the selected item index
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _deleteClass(_selectedItemIndex);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
