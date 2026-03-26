import 'package:flutter/material.dart';
import 'dashboard_v2_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardV2Screen(),
    const Center(
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
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "בית"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "אחר"),
        ],
      ),
    );
  }
}