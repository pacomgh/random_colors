import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorPage extends StatefulWidget {
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  double sliderBackgroundOpacity = 1.0;
  Color? backgroundColor, animatedBackgroundColor;
  int red = 0,
      green = 0,
      blue = 0,
      animatedRed = 0,
      animatedBlue = 0,
      animatedGreen = 0;
  Color textColor = Color.fromRGBO(0, 0, 0, 1.0);
  final random = Random();
  bool showSurprise = false, showCustom = false, showFun = false;
  Timer? timer;
  double randomWith = 0, randomHeight = 0;

  @override
  void initState() {
    super.initState();
    backgroundColor = Color.fromRGBO(255, 255, 255, 0);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
              changeTextColor();
            });
          },
          child: AnimatedContainer(
            color: backgroundColor,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
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
                  'Tap to change color',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
                SizedBox(height: 10),
                if (showSurprise)
                  Container(
                    width: double.infinity,
                    alignment: AlignmentGeometry.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Switch(
                                  value: showCustom,
                                  onChanged: (bool value) {
                                    setState(() {
                                      if (showFun) {
                                        showFun = false;
                                        timer?.cancel();
                                      }

                                      showCustom = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Custom Color',
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Switch(
                                  value: showFun,
                                  onChanged: (bool value) {
                                    setState(() {
                                      if (showCustom) showCustom = false;
                                      showFun = value;
                                    });
                                    if (showFun) {
                                      animateColors();
                                    } else {
                                      timer?.cancel();
                                      print('🛑 animate colors detenido');
                                    }
                                  },
                                ),
                                Text(
                                  'Tap for fun',
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                if (showCustom)
                  Column(
                    children: [
                      Text('Red', style: TextStyle(color: textColor)),
                      SizedBox(height: 5),
                      Slider(
                        value: red.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            red = value.toInt();
                            backgroundColor = Color.fromRGBO(
                              red,
                              green,
                              blue,
                              sliderBackgroundOpacity,
                            );
                            changeTextColor();
                          });

                          debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Text('Blue', style: TextStyle(color: textColor)),
                      SizedBox(height: 5),
                      Slider(
                        value: green.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            green = value.toInt();
                            backgroundColor = Color.fromRGBO(
                              red,
                              green,
                              blue,
                              sliderBackgroundOpacity,
                            );
                            changeTextColor();
                          });
                          debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Text('Green', style: TextStyle(color: textColor)),
                      SizedBox(height: 5),
                      Slider(
                        value: blue.toDouble(),
                        min: 0,
                        max: 255,
                        onChanged: (double value) {
                          setState(() {
                            blue = value.toInt();
                            backgroundColor = Color.fromRGBO(
                              red,
                              green,
                              blue,
                              sliderBackgroundOpacity,
                            );
                            changeTextColor();
                          });
                          debugPrint('🟢 $backgroundColor');
                        },
                      ),

                      // Slider(
                      //   value: sliderBackgroundOpacity,
                      //   min: 0,
                      //   max: 255,
                      //   onChanged: (double value) {
                      //     setState(() {
                      //       sliderBackgroundOpacity = value;
                      //       backgroundColor = Color.fromRGBO(
                      //         red,
                      //         green,
                      //         blue,
                      //         sliderBackgroundOpacity,
                      //       );
                      //     });
                      //     debugPrint('🟢 $backgroundColor');
                      //   },
                      // ),
                    ],
                  ),
                SizedBox(height: 20),
                if (showFun)
                  AnimatedContainer(
                    width: randomWith != 0 ? randomWith : 100,
                    height: randomHeight != 0 ? randomHeight : 100,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: animatedBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color generateRandomColor({required bool changeOpacity}) {
    red = random.nextInt(256);
    blue = random.nextInt(256);
    green = random.nextInt(256);
    return Color.fromRGBO(
      red,
      green,
      blue,
      changeOpacity ? random.nextDouble() * 1.0 : sliderBackgroundOpacity,
    );
  }

  Color generateRandomColorFun() {
    animatedRed = random.nextInt(256);
    animatedBlue = random.nextInt(256);
    animatedGreen = random.nextInt(256);
    return Color.fromRGBO(
      animatedRed,
      animatedBlue,
      animatedGreen,
      sliderBackgroundOpacity,
    );
  }

  bool isDark(Color color) {
    double luminance = color.computeLuminance();
    return luminance < 0.5;
  }

  (double, double) randomContainerSize() {
    return (random.nextDouble() * 100, random.nextDouble() * 100);
  }

  Color changeTextColor() {
    return textColor = isDark(backgroundColor!) ? Colors.white : Colors.black;
  }

  void animateColors() {
    // print('🌟animate colors');
    timer?.cancel();
    double width = 0;
    double height = 0;
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        animatedBackgroundColor = generateRandomColorFun();
        backgroundColor = generateRandomColor(changeOpacity: false);
        // print('🌟 main color $backgroundColor');
        changeTextColor();
        (width, height) = randomContainerSize();
        randomWith = width;
        randomHeight = height;
        // print('🌟 random wi $randomWith');
        // print('🌟 random he $randomHeight');

        // print('🌟 animated back colo $animatedBackgroundColor');
      });
    });
  }
}
