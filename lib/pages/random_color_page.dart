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
  bool showSurprise = false, showCustom = false, showFun = false;

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
          onLongPress: () {
            setState(() {
              showSurprise = !showSurprise;
              debugPrint('🌟 surprise $showSurprise');
            });
          },
          onTap: () {
            setState(() {
              backgroundColor = generateRandomColor(changeOpacity: false);
              debugPrint('🌟 ${isDark(backgroundColor!)}');
              debugPrint('🌟 ${backgroundColor!.g}');
              textColor = isDark(backgroundColor!)
                  ? Colors.white
                  : Colors.black;
            });
          },
          child: Container(
            color: backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Hello there!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Long tap for surprise',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (showSurprise)
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    alignment: AlignmentGeometry.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Switch(
                                  value: showCustom,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showCustom = value;
                                    });
                                  },
                                ),
                                Text('Custom Color'),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Switch(
                                  value: showFun,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showFun = value;
                                    });
                                  },
                                ),
                                Text('Tap for fun'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (showCustom)
                  Column(
                    children: [
                      Slider(
                        value: backgroundColor!.r.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            backgroundColor = Color.fromRGBO(
                              backgroundColor!.r.toInt(),
                              backgroundColor!.g.toInt(),
                              backgroundColor!.b.toInt(),
                              1.0,
                            );
                          });
                          debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Slider(
                        value: backgroundColor!.r.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            backgroundColor = Color.fromRGBO(
                              backgroundColor!.r.toInt(),
                              backgroundColor!.g.toInt(),
                              backgroundColor!.b.toInt(),
                              1.0,
                            );
                          });
                          debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Slider(
                        value: backgroundColor!.b.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            backgroundColor = Color.fromRGBO(
                              backgroundColor!.r.toInt(),
                              backgroundColor!.g.toInt(),
                              backgroundColor!.b.toInt(),
                              1.0,
                            );
                          });
                          debugPrint('🟢 $backgroundColor');
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color generateRandomColor({required bool changeOpacity}) {
    return Color.fromRGBO(
      backgroundColor!.r.toInt(),
      backgroundColor!.g.toInt(),
      backgroundColor!.b.toInt(),
      changeOpacity ? random.nextDouble() * 1.0 : 1.0,
    );
  }

  bool isDark(Color color) {
    double luminance = color.computeLuminance();
    return luminance < 0.5;
  }
}
