import 'package:flutter/material.dart';
 
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
 
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
 
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
 
  final List<Map<String, String>> pages = [
    {
      "image": "assets/icons/icon1.png",
      "title": "ברוך הבא ל‑Flexora",
      "subtitle": "המערכת החכמה שתעזור לך לנהל את העסק שלך בקלות וביעילות."
    },
    {
      "image": "assets/icons/icon2.png",
      "title": "ניהול לקוחות חכם",
      "subtitle": "עקוב אחרי לקוחות, תורים, תשלומים והכול במקום אחד."
    },
    {
      "image": "assets/icons/icon3.png",
      "title": "התחל עכשיו",
      "subtitle": "בוא נבנה את העסק שלך לרמה הבאה."
    },
  ];
 
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
 
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // עמודים
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    pages[index]["image"]!,
                    height: width * 0.45,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    pages[index]["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      pages[index]["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
 
          // נקודות אינדיקציה
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFFD4AF37)
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
 
          // כפתור תחתון
          Positioned(
            left: 32,
            right: 32,
            bottom: 40,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == pages.length - 1) {
                    // כאן נעבור למסך הבית
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _currentPage == pages.length - 1 ? "התחל" : "הבא",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 