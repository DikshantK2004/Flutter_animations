import 'dart:math';

import 'package:flutter/material.dart';

class ChainedAnimation extends StatefulWidget {
  const ChainedAnimation({super.key});

  @override
  State<ChainedAnimation> createState() => _ChainedAnimationState();
}

class _ChainedAnimationState extends State<ChainedAnimation>
    with TickerProviderStateMixin {
  // for many animations
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation =
        Tween(begin: 0.0, end: - pi / 2)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation2 =
        Tween(begin: 0.0, end:pi).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.bounceOut,
      ),
    ); // atleast initialization is necessary
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

        _animation2 = Tween(begin: _animation2.value, end: _animation2.value + pi).animate(
          CurvedAnimation( // we can't do it above itself, because there it was initiallly uniitialized
            parent: _controller2,
            curve: Curves.bounceOut,
          ),
        );
        _controller2
          ..reset()
          ..forward(); // this is like calling the animation to run
      }
    });

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // for continuity
        _animation = Tween(begin: _animation.value, end: _animation.value - pi / 2)
            .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceOut,
          ),
        );

        _controller
          ..reset()
          ..forward();
        // this is like calling the animation to run
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();

    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.4),
        body: Center(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_animation.value),
                  child: AnimatedBuilder(
                      animation: _controller2,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateX(_animation2.value),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(100),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(100),
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      }),
                );
              }),
        ));
  }
}
