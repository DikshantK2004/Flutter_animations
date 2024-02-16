// bouncing and scalign order confirmation page inspired by https://dribbble.com/shots/19749136-Design-for-Flash-Message

import 'package:flutter/material.dart';

class AnimatedPrompt extends StatefulWidget {
  const AnimatedPrompt({super.key});

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _yAnimation = Tween<Offset>(
      begin: const Offset(0, 0), // basically if the container scales down at same place, it is not correct, so slightly move it by small offset
      end: const Offset(0, -0.3),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _iconScaleAnimation = Tween<double>(
      begin: 7,
      end: 6,
    ).animate( // smaller the value smaller the icon
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _containerScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 0.25,
    ).animate( // smaller the value smaller the icon container
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Icons',
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'Thank You for Your Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your order is confirmed and will be delivered soon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: SlideTransition(
                  position: _yAnimation,
                  child: ScaleTransition(
                    scale: _containerScaleAnimation,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
