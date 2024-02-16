import 'dart:math';
import 'package:flutter/material.dart';

class AxisRotation extends StatefulWidget {
  const AxisRotation({super.key});

  @override
  State<AxisRotation> createState() => _AxisRotationState();
}

class _AxisRotationState extends State<AxisRotation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat();
    _animation = Tween(begin: 0.0, end: 2 * pi)
        .animate(_controller); // Tween is like BeTween
    super.initState();
  }

  @override
  void dispose() {
   
    _controller.dispose();
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Axis Rotation',
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      backgroundColor: Colors.white.withOpacity(0.4),
      body: Center(
        // animated Builder used to inform about rerendering of the widget
        child: AnimatedBuilder(
            // animated Builder applied mostly to transforms
            animation: _controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center, // rotation along alignment center
                // origin: const Offset(50, 50), // rotation origin (counted from topLeft of the container)
                transform: Matrix4.identity()
                  ..rotateY(_animation
                      .value), // basically rotate works in place on matrix
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              );
            }),
      ),
    );
  }
}
