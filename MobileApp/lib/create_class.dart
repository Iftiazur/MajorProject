import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CreateClassForm extends StatefulWidget {
  @override
  _CreateClassFormState createState() => _CreateClassFormState();
}

class _CreateClassFormState extends State<CreateClassForm> {
  final _formKey = GlobalKey<FormState>();

  String _className = '';
  String _courseCode = '';
  String _branch = 'ECE';
  String _degreeOrDiploma = 'Degree';
  String _semester = '1';
  String _totalStudents = '';

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/class_data');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return File('${folder.path}/class_data.csv');
  }

  Future<List<List<dynamic>>> _readDataFromFile() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return const CsvToListConverter().convert(contents);
      }
    } catch (e) {
      print('Error reading data from file: $e');
    }
    return [];
  }

  Future<void> _writeDataToFile(List<List<dynamic>> data) async {
    final file = await _localFile;
    await file.writeAsString(const ListToCsvConverter().convert(data));
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form validation successful, handle form data
      print('Class Name: $_className');
      print('Course Code: $_courseCode');
      print('Branch: $_branch');
      print('Degree/Diploma: $_degreeOrDiploma');
      print('Semester: $_semester');
      print('Total Students: $_totalStudents');

      final List<List<dynamic>> newData = [
        [
          'Class Name',
          'Course Code',
          'Branch',
          'Degree/Diploma',
          'Semester',
          'Total Students',
        ],
        [
          _className,
          _courseCode,
          _branch,
          _degreeOrDiploma,
          _semester,
          _totalStudents,
        ]
      ];

      final existingData = await _readDataFromFile();
      existingData.addAll(newData);
      await _writeDataToFile(existingData);

      // Navigate to display data screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DisplayDataScreen(data: newData, showAllData: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Class Name'),
                onChanged: (value) => _className = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the class name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Course Code'),
                onChanged: (value) => _courseCode = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course code';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _branch,
                onChanged: (value) => setState(() => _branch = value!),
                items: ['ECE', 'CSE', 'IE', 'CE', 'FET']
                    .map((String branch) => DropdownMenuItem<String>(
                          value: branch,
                          child: Text(branch),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Branch'),
              ),
              DropdownButtonFormField<String>(
                value: _degreeOrDiploma,
                onChanged: (value) => setState(() {
                  _degreeOrDiploma = value!;
                  _semester = '1'; // Reset semester when Degree/Diploma changes
                }),
                items: ['Degree', 'Diploma']
                    .map((String degree) => DropdownMenuItem<String>(
                          value: degree,
                          child: Text(degree),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Degree/Diploma'),
              ),
              DropdownButtonFormField<String>(
                value: _semester,
                onChanged: (value) => setState(() => _semester = value!),
                items: (_degreeOrDiploma == 'Degree')
                    ? ['1', '2', '3', '4', '5', '6', '7', '8']
                        .map((String semester) => DropdownMenuItem<String>(
                              value: semester,
                              child: Text(semester),
                            ))
                        .toList()
                    : ['1', '2', '3', '4', '5', '6']
                        .map((String semester) => DropdownMenuItem<String>(
                              value: semester,
                              child: Text(semester),
                            ))
                        .toList(),
                decoration: InputDecoration(labelText: 'Semester'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total Students'),
                onChanged: (value) => _totalStudents = value,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayDataScreen extends StatelessWidget {
  final List<List<dynamic>> data;
  final bool showAllData;

  const DisplayDataScreen({required this.data, required this.showAllData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Class Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateClassForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final classData = data[index];
          final className = classData[0].toString();

          if (!showAllData && className == 'Class Name') {
            return SizedBox.shrink(); // Return an empty widget
          }

          return ListTile(
            title: Text(
              className,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Course Code: ${classData[1]}'),
                Text('Branch: ${classData[2]}'),
                Text('Degree/Diploma: ${classData[3]}'),
                Text('Semester: ${classData[4]}'),
                Text('Total Students: ${classData[5]}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
