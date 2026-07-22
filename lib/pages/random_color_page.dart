import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorPage extends StatefulWidget {
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  double sliderBackgroundOpacity = 1.0;
  Color? backgroundColor;

  Color textColor = Color.fromRGBO(0, 0, 0, 1.0);
  final random = Random();

  @override
  void initState() {
    super.initState();
    backgroundColor = Color.fromRGBO(255, 255, 255, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              backgroundColor = generateRandomColor(changeOpacity: false);
            });
          },
          child: Container(
            color: backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                'Hello there!',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color generateRandomColor({required bool changeOpacity}) {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      changeOpacity ? random.nextDouble() * 1.0 : 1.0,
    );
  }
}
