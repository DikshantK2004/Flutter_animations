import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/animated_prompt.dart';
import 'package:flutter_animations/animations/axis_rotation.dart';
import 'package:flutter_animations/animations/chained_animation.dart';
import 'package:flutter_animations/animations/color_animation.dart';
import 'package:flutter_animations/animations/implicit_animations.dart';

var animations = List<Map<String, dynamic>>.from([
  {
    'title': 'Axis Rotation',
    'animation': const AxisRotation(),
  },
  {
    'title': 'Color Animation',
    'animation': const ColorAnimation(),
  },
  {
    'title': 'Implicit Animation',
    'animation': const ImplicitAnimation(),
  },
  {
    'title': 'Chained Animation',
    'animation': const ChainedAnimation(),
  },
  {
    'title': 'Animated Prompt',
    'animation': const AnimatedPrompt(),
  },
]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: animations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                title: Text(animations[index]['title']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => animations[index]['animation'],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
