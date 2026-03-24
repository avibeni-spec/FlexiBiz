import 'package:flutter/material.dart';
import '../services/onboarding_screen.dart'; // עדכן נתיב אם צריך
 
class FlexSplash extends StatefulWidget {
  const FlexSplash({super.key});
 
  @override
  State<FlexSplash> createState() => _FlexSplashState();
}
 
class _FlexSplashState extends State<FlexSplash> {
  @override
  void initState() {
    super.initState();
 
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
 
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
 
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/flexora_icon.png',
              width: screenWidth * 0.35,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
 