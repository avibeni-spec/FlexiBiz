import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FlexOraApp());
}

class FlexOraApp extends StatelessWidget {
  const FlexOraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}