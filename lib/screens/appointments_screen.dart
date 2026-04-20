import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';
import 'appointment_details_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final appointments = MockAppointments.all
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Appointments",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 32),

              Expanded(
                child: appointments.isEmpty
                    ? const Center(
                        child: Text(
                          "No appointments yet",
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    : ListView.separated(
                        itemCount: appointments.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final a = appointments[index];

                          return GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AppointmentDetailsScreen(
                                    appointment: a,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  // Time
                                  SizedBox(
                                    width: 64,
                                    child: Text(
                                      a.timeLabel,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          a.client,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${a.service} • ${_statusLabel(a.status)}",
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white38,
                                  ),
                                ],
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

  String _statusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return "Scheduled";
      case AppointmentStatus.checkedIn:
        return "Checked In";
      case AppointmentStatus.paid:
        return "Paid";
      case AppointmentStatus.cancelled:
        return "Cancelled";
    }
  }
}