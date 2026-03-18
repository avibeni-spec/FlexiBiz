import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/business_type_selection_screen.dart';
import 'screens/main_dashboard_screen.dart';
 
void main() {
  runApp(const FlexiBizApp());
}
 
class FlexiBizApp extends StatelessWidget {
  const FlexiBizApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      routes: {
        "/businessType": (context) => const BusinessTypeSelectionScreen(),
        "/dashboard": (context) => const MainDashboardScreen(),
      },
    );
  }
}
 