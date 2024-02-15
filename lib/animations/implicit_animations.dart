import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

const defaultWidth = 100.0;

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  var _isZoomedIn = false;
  var _buttonTitle = 'Zoom In';
  var _width = defaultWidth;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer( // thisis the implicit animation container
                duration: const Duration(
                  milliseconds: 370,
                ),
                width: _width,
                curve: _curve,
                child: Image.asset(
                  'assets/photo.png',
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isZoomedIn = !_isZoomedIn;
                _buttonTitle = _isZoomedIn ? 'Zoom Out' : 'Zoom In';
                _width = _isZoomedIn
                    ? MediaQuery.of(context).size.width
                    : defaultWidth;
                _curve = _isZoomedIn ? Curves.easeIn: Curves.easeOut;
              });
            },
            child: Text(
              _buttonTitle,
            ),
          ),
        ],
      ),
    );
  }
}