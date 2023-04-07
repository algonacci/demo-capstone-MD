import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class FetchingApiPage extends StatefulWidget {
  const FetchingApiPage({super.key});

  @override
  State<FetchingApiPage> createState() => _FetchingApiPageState();
}

class _FetchingApiPageState extends State<FetchingApiPage> {
  File? _image;
  final picker = ImagePicker();

  String? _predictedImageUrl;

  String? _result;
  String? _result2;

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
        title: const Text("Predict Through API"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Text('Select image'),
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
                  child: const Text('Take picture'),
                ),
              ],
            ),
            if (_image != null)
              Image.file(
                _image!,
                key: ValueKey(_image?.path),
              ),
            if (_predictedImageUrl != null)
              Image.network(
                _predictedImageUrl!,
                key: ValueKey(_predictedImageUrl),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                        // 'http://127.0.0.1:5000/predict',
                        'http://192.168.0.107:5000/predict',
                      ),
                    );
                    request.files.add(
                      await http.MultipartFile.fromPath('image', _image!.path),
                    );
                    http.StreamedResponse response = await request.send();
                    if (response.statusCode == 200) {
                      String responseString =
                          await response.stream.bytesToString();
                      Map<String, dynamic> jsonResponse =
                          json.decode(responseString);
                      String predictedImageUrl = jsonResponse['status']['data'];
                      setState(() {
                        _predictedImageUrl = predictedImageUrl;
                      });

                      debugPrint(
                        await response.stream.bytesToString(),
                      );
                      debugPrint('berhasil');
                    } else {
                      debugPrint(response.reasonPhrase);
                      debugPrint('gagal');
                    }
                  },
                  child: const Text(
                    "Predict!",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var requestCC = http.MultipartRequest(
                      'GET',
                      Uri.parse(
                        'http://192.168.0.107:8000',
                      ),
                    );
                    http.StreamedResponse responseCC = await requestCC.send();
                    if (responseCC.statusCode == 200) {
                      String responseString =
                          await responseCC.stream.bytesToString();
                      Map<String, dynamic> jsonResponse =
                          json.decode(responseString);
                      String result = jsonResponse['message'];
                      String result2 = jsonResponse['title'];
                      setState(() {
                        _result = result;
                        _result2 = result2;
                        debugPrint(_result);
                        debugPrint(_result2);
                      });

                      debugPrint(
                        await responseCC.stream.bytesToString(),
                      );
                      debugPrint('berhasil');
                    } else {
                      debugPrint(responseCC.reasonPhrase);
                      debugPrint('gagal');
                    }
                  },
                  child: Text('GET INFO'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_result != null)
                  Text(
                    _result!,
                    style: TextStyle(fontSize: 18),
                  ),
                if (_result2 != null)
                  Text(
                    '\n  $_result2!',
                    style: TextStyle(fontSize: 18),
                  ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
