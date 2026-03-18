import 'package:flutter/material.dart';
 
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0D0D0D), // רקע שחור אלגנטי
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40),
 
              // לוגו / שם האפליקציה
              Column(
                children: [
                  Text(
                    "FlexiBiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w300, // דק ויוקרתי
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
 
              // טקסט מרכזי
              Column(
                children: [
                  Text(
                    "ניהול העסק שלך.\nברמה אחרת.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "פתרון חכם, מהיר ויוקרתי לניהול תורים ולקוחות.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
 
              // כפתור התחל
              SizedBox(
                width: double.infinity,
                child: _StartButton(),
              ),
 
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
 
class _StartButton extends StatelessWidget {
  const _StartButton();
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/businessType");
      },
      child: const Text(
        "התחל",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
 