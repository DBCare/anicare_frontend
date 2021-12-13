import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/pages/main_menu.dart';

import '../main.dart';

class RecognizeTextScreen extends StatefulWidget {
  const RecognizeTextScreen({
    Key? key,
  }) : super(key: key);

  @override
  RecognizeTextScreenState createState() => RecognizeTextScreenState();
}

class RecognizeTextScreenState extends State<RecognizeTextScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    int _cameraIndex = 0;
    final CameraDescription camera = cameras[0];
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            final textDetector = GoogleMlKit.vision.textDetector();
            final inputImage = InputImage.fromFile(File(image.path));
            final RecognisedText recognisedText =
                await textDetector.processImage(inputImage);

            String text = recognisedText.text;
            for (TextBlock block in recognisedText.blocks) {
              final Rect rect = block.rect;
              final List<Offset> cornerPoints = block.cornerPoints;
              final String text = block.text;
              final List<String> languages = block.recognizedLanguages;

              for (TextLine line in block.lines) {
                // Same getters as TextBlock
                for (TextElement element in line.elements) {}
              }
            }
            debugPrint(text);

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MainMenu(),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
