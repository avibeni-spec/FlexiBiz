import 'package:flutter/material.dart';
import '../widgets/flexora_app_bar.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: const FlexoraAppBar(),
      body: const Center(
        child: Text(
          "תורים",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}