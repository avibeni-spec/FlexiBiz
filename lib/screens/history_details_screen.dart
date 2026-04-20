import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final Appointment appointment;

  const HistoryDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final a = appointment;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(color: Colors.white),
              const SizedBox(height: 24),

              Text(a.client,
                  style:
                      const TextStyle(color: Colors.white, fontSize: 28)),
              const SizedBox(height: 6),
              Text("${a.timeLabel} • ${a.service}",
                  style:
                      const TextStyle(color: Colors.white54)),

              const SizedBox(height: 24),
              Text("Amount: ₪${a.price}",
                  style:
                      const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}