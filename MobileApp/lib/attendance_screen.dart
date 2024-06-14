import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class AttendanceScreen extends StatefulWidget {
  final List<String> recognizedFaces;

  AttendanceScreen({required this.recognizedFaces});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? filePath;
  String? originalFileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        originalFileName = result.files.single.name;
      });
    }
  }

  Future<void> updateExcel() async {
    if (filePath == null) {
      print("No file selected.");
      return;
    }

    var file = File(filePath!);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Assuming the sheet name is 'Sheet1'
    var sheet = excel['Sheet1'];

    // Get the first column values
    List<String> firstColumn = [];
    for (var row in sheet.rows) {
      firstColumn.add(row[0]?.value.toString() ?? '');
    }

    // Add new column with the current date and time as the header
    String currentDatetime =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    int columnIndex = sheet.maxCols;
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: 0))
        .value = currentDatetime;

    // Update attendance
    for (int i = 1; i < firstColumn.length; i++) {
      String student = firstColumn[i];
      sheet
          .cell(
              CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: i))
          .value = widget.recognizedFaces.contains(student) ? 1 : 0;
    }

    // Save the updated file
    final String? path = await FilePicker.platform.getDirectoryPath();
    if (path != null) {
      final String fileName = originalFileName ?? "Attendance.xlsx";
      final File file = File('$path/$fileName');
      var fileBytes = excel.encode();
      if (fileBytes != null) {
        file.writeAsBytesSync(fileBytes);
        print("Excel file updated successfully at $path/$fileName.");
      } else {
        print("Failed to update the Excel file.");
      }
    } else {
      print("No directory selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Sheet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick Excel File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateExcel();
              },
              child: Text('Update Attendance'),
            ),
            SizedBox(height: 20),
            Text(filePath != null
                ? 'Selected File: $originalFileName'
                : 'No file selected.'),
            SizedBox(height: 20),
            // Display recognized faces list
            Expanded(
              child: ListView.builder(
                itemCount: widget.recognizedFaces.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${widget.recognizedFaces[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
