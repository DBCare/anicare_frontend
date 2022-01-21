import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:async';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/pages/scan_result.dart';

class CropScreen extends StatefulWidget {
  final String imgPath;

  CropScreen({required this.imgPath});

  @override
  _CropScreenState createState() => _CropScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CropScreenState extends State<CropScreen> {
  late AppState state;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.picked;
    _cropImage(widget.imgPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUpInformationBar(
          color: Color(0xffF9F9F9), pageContext: context, title: 'Crop Image'),
      body: const Center(),
    );
  }

  Future<Null> _cropImage(String imgPath) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imgPath,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blueAccent.shade700,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.blueAccent.shade700,
            activeControlsWidgetColor: Colors.blueAccent.shade700,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      final textDetector = GoogleMlKit.vision.textDetector();
      final inputImage = InputImage.fromFile(File(imageFile!.path));
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
          builder: (context) => scanResult(
            ingredientL: text,
          ),
        ),
      );
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
