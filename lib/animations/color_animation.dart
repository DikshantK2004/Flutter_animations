import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorAnimation extends StatefulWidget {
  const ColorAnimation({super.key});

  @override
  State<ColorAnimation> createState() => _ColorAnimationState();
}

class _ColorAnimationState extends State<ColorAnimation> {
  Color getRandomColor() => Color(
        0xFF000000 +
            math.Random().nextInt(
              0x00FFFFFF,
            ),
      );
  late Color _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Color Animation',
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: ColorTween(begin: Colors.red, end: _color),
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(() {
              _color = getRandomColor();
            });
          },
          builder: (context, Color? color, child) {
            return ColorFiltered(
              // changing colors
              colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
              child: child!,
            );
          },
          child: Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 2),
              color: Colors
                  .white, // you must atleaset initilaizee it for color animation to work
            ),
          ),
        ),
      ),
    );
  }
}
