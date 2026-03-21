import 'package:flutter/material.dart';

class FlexoraSplash extends StatefulWidget {
  const FlexoraSplash({super.key});

  @override
  State<FlexoraSplash> createState() => _FlexoraSplashState();
}

class _FlexoraSplashState extends State<FlexoraSplash>
    with TickerProviderStateMixin {
  late AnimationController lineCtrl;
  late AnimationController textCtrl;

  @override
  void initState() {
    super.initState();

    lineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      textCtrl.forward();
    });
  }

  @override
  void dispose() {
    lineCtrl.dispose();
    textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: lineCtrl,
              builder: (context, child) {
                return Container(
                  width: 200 * lineCtrl.value,
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF2D39B),
                        Color(0xFFD0A45A),
                        Color(0xFF8A6A32),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            FadeTransition(
              opacity: textCtrl,
              child: const Text(
                "FLEXORA",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
