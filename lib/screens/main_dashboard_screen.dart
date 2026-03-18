import 'package:flutter/material.dart';
import 'clients_screen.dart';
import 'appointments_screen.dart';
import 'settings_screen.dart';
 
class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});
 
  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}
 
class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;
 
  final List<Widget> _pages = [
    const Center(
      child: Text(
        "דף הבית",
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    ),
    const ClientsScreen(),
    const AppointmentsScreen(),
    const SettingsScreen(),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "FlexiBiz",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 26,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
 
      body: _pages[_selectedIndex],
 
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "בית",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "לקוחות",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "תורים",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "הגדרות",
          ),
        ],
      ),
    );
  }
}
 