import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';
import 'payment_screen.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("${appointment.client} • ${appointment.service}"),
            Text("${appointment.timeLabel} (${appointment.duration.inMinutes}m)"),
            ElevatedButton(
              onPressed: () => MockAppointments.checkIn(appointment),
              child: const Text("Check In"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(appointment: appointment),
                  ),
                );
              },
              child: const Text("Payment"),
            ),
          ],
        ),
      ),
    );
  }
}