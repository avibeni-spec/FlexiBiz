import 'package:flutter/material.dart';
import 'theme/theme.dart'; // זה הקובץ שבו מוגדר flexoraTheme
import 'screens/splash/flexora_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlexoraApp());
}

class FlexoraApp extends StatelessWidget {
  const FlexoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: flexoraTheme, // זה ה-Theme האמיתי שלך
      home: const FlexoraSplash(), // מסך הפתיחה
    );
  }
}
