import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:trial/attendance_screen.dart ';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Picture Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TakePictureScreen(),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  Future<void> _takePicture() async {
    try {
      // Ensure that the camera controller is initialized
      await _initializeControllerFuture;

      // Get the directory for storing images
      final appDirectory = await getApplicationDocumentsDirectory();

      // Construct a file path for the new image
      final imagePath = path.join(appDirectory.path, '${DateTime.now()}.png');

      // Take a picture and save it to the file path
      XFile picture = await _controller.takePicture();

      // Save the captured image to the specified file path
      final File savedImage = File(picture.path);
      await savedImage.copy(imagePath);

      // Update the image path to the saved image
      setState(() {
        _imagePath = imagePath;
      });

      // Display the captured image
      _displayPicture();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      _displayPicture();
    }
  }

  void _displayPicture() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(imagePath: _imagePath),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _selectImage,
            child: Icon(Icons.image),
          ),
          FloatingActionButton(
            onPressed: _takePicture,
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  List<String> recognizedFaces = [];
  int numFacesDetected = 0;

  Future<void> _sendImageToAPI(String imagePath) async {
    String apiUrl = 'https://native-key-raven.ngrok-free.app/detect_faces';

    // Prepare the image file
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    // Send POST request to Flask API
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        recognizedFaces = List<String>.from(data['recognized_faces']);
        numFacesDetected = data['num_faces_detected'];
      });
    } else {
      print('Failed to recognize faces. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _sendImageToAPI(widget.imagePath);
  }

  // Empty function to handle the Next button press
  void _onNextPressed() {
    // Pass recognized faces list to AttendanceScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AttendanceScreen(recognizedFaces: recognizedFaces),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Picture Preview')),
      body: Column(
        children: [
          Expanded(
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          ElevatedButton(
            onPressed: _onNextPressed,
            child: Text('Next'),
          ),
          SizedBox(height: 20),
          Text(
            'Number of Faces Detected: $numFacesDetected',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: recognizedFaces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${recognizedFaces[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
