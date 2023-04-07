import 'package:demo_capstone/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Capstone"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/fetching");
                },
                child: const Button(
                  text: "API",
                  icon: Icons.cabin,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/tflite");
                },
                child: Button(
                  text: "TensorFlow Lite",
                  icon: Icons.camera,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
