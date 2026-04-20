import 'package:flutter/material.dart';
import 'main_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainDashboardScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0D0D0D),
      body: Center(
        child: _BrandTitle(),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w300,
          letterSpacing: 2.2,
        ),
        children: [
          TextSpan(text: 'Flex'),
          TextSpan(
            text: 'O',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(text: 'ra'),
        ],
      ),
    );
  }
}
