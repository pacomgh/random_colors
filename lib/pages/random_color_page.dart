import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// Creates a page that displays random colors.
class RandomColorPage extends StatefulWidget {
  /// Creates a page that displays random colors.
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  double sliderBackgroundOpacity = 1.0;
  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 0);
  Color animatedBackgroundColor = const Color.fromRGBO(255, 255, 255, 0);
  int red = 0;
  int green = 0;
  int blue = 0;
  int animatedRed = 0;
  int animatedBlue = 0;
  int animatedGreen = 0;
  Color textColor = const Color.fromRGBO(0, 0, 0, 1.0);
  final random = Random();
  bool showSurprise = false;
  bool showCustom = false;
  bool showFun = false;
  Timer? timer;
  double randomWith = 0;
  double randomHeight = 0;
  int maxRandomColorValue = 256;
  int maxLittleContainerSize = 100;
  final double luminanceValueTop = 0.5;

  @override
  void initState() {
    super.initState();
    backgroundColor = const Color.fromRGBO(255, 255, 255, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              showSurprise = !showSurprise;
              // debugPrint('🌟 surprise $showSurprise');
            });
          },
          onTap: () {
            setState(() {
              backgroundColor = generateRandomColor(changeOpacity: false);
              // debugPrint('🌟 ${isDark(backgroundColor!)}');
              // debugPrint('🌟 ${backgroundColor!.g}');
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
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 10),
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
                            const SizedBox(width: 10),
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
                                      // print('🛑 animate colors detenido');
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
                const SizedBox(height: 20),
                if (showCustom)
                  Column(
                    children: [
                      Text('Red', style: TextStyle(color: textColor)),
                      const SizedBox(height: 5),
                      Slider(
                        value: red.toDouble(),
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

                          // debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Text('Blue', style: TextStyle(color: textColor)),
                      const SizedBox(height: 5),
                      Slider(
                        value: green.toDouble(),
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
                          // debugPrint('🟢 $backgroundColor');
                        },
                      ),
                      Text('Green', style: TextStyle(color: textColor)),
                      const SizedBox(height: 5),
                      Slider(
                        value: blue.toDouble(),
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
                          // debugPrint('🟢 $backgroundColor');
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
                const SizedBox(height: 20),
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
    red = random.nextInt(maxRandomColorValue);
    blue = random.nextInt(maxRandomColorValue);
    green = random.nextInt(maxRandomColorValue);

    return Color.fromRGBO(
      red,
      green,
      blue,
      changeOpacity ? random.nextDouble() * 1.0 : sliderBackgroundOpacity,
    );
  }

  Color generateRandomColorFun() {
    animatedRed = random.nextInt(maxRandomColorValue);
    animatedBlue = random.nextInt(maxRandomColorValue);
    animatedGreen = random.nextInt(maxRandomColorValue);

    return Color.fromRGBO(
      animatedRed,
      animatedBlue,
      animatedGreen,
      sliderBackgroundOpacity,
    );
  }

  bool isDark(Color color) {
    final double luminance = color.computeLuminance();

    return luminance < luminanceValueTop;
  }

  (double, double) randomContainerSize() {
    return (
      random.nextDouble() * maxLittleContainerSize,
      random.nextDouble() * maxLittleContainerSize,
    );
  }

  Color changeTextColor() {
    return textColor = isDark(backgroundColor) ? Colors.white : Colors.black;
  }

  void animateColors() {
    // print('🌟animate colors');
    timer?.cancel();
    double width = 0;
    double height = 0;
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
