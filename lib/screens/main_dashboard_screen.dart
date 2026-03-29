import 'package:flutter/material.dart';
import 'dashboard_v2_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardV2Screen(), // ✅ הדשבורד החדש באמת נטען
    Center(
      child: Text(
        "מסך נוסף",
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "בית"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "אחר"),
        ],
      ),
    );
  }
}