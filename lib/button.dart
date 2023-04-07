import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;

  const Button({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
        bottom: 24,
      ),
      height: 120,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
