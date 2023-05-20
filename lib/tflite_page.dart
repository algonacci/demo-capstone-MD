import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TfLitePage extends StatefulWidget {
  const TfLitePage({super.key});

  @override
  State<TfLitePage> createState() => _TfLitePageState();
}

class _TfLitePageState extends State<TfLitePage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Predict with TF Lite",
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Text(
                  "Select Image",
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: const Text(
                  "Take Picture",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
