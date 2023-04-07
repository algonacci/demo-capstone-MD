import 'package:demo_capstone/fetching_api_page.dart';
import 'package:demo_capstone/home_page.dart';
import 'package:demo_capstone/tflite_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        "/fetching": (context) => const FetchingApiPage(),
        "/tflite": (context) => const TfLitePage(),
      },
    );
  }
}
