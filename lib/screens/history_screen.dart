import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';
import 'history_details_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = MockAppointments.all.where(
      (a) =>
          a.status == AppointmentStatus.paid ||
          a.status == AppointmentStatus.cancelled,
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("History",
                  style: TextStyle(color: Colors.white, fontSize: 28)),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: history.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final a = history[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                HistoryDetailsScreen(appointment: a),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "${a.timeLabel} • ${a.client} • ${a.service}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}