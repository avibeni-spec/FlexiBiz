import 'package:flutter/material.dart';
import 'screens/splash/flex_splash.dart';
 
void main() {
  runApp(const FlexoraApp());
}
 
class FlexoraApp extends StatelessWidget {
  const FlexoraApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Manrope',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFF9E5BC),
        ),
      ),
      home: const FlexSplash(),
    );
  }
}
 