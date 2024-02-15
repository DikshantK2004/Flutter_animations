import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/axis_rotation.dart';
import 'package:flutter_animations/animations/chained_animation.dart';
import 'package:flutter_animations/animations/implicit_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false ,
      debugShowMaterialGrid: false,
      home: const ImplicitAnimation(),
    );
  }
}

