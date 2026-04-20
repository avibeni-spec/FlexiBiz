import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';
import '../state/service_prices.dart';

class NewAppointmentScreen extends StatefulWidget {
  const NewAppointmentScreen({super.key});

  @override
  State<NewAppointmentScreen> createState() =>
      _NewAppointmentScreenState();
}

class _NewAppointmentScreenState
    extends State<NewAppointmentScreen> {
  String? client;
  String? service;
  Duration duration = const Duration(minutes: 30);
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 0);

  final clients = ["Noa", "Sarah", "Daniel"];
  final services = ServicePrices.services.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("New Appointment"),
        backgroundColor: const Color(0xFF0D0D0D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dropdown("Client", client, clients, (v) {
              setState(() => client = v);
            }),
            _dropdown("Service", service, services, (v) {
              setState(() {
                service = v;
                if (v != null) {
                  duration =
                      ServicePrices.getDuration(v);
                }
              });
            }),
            const SizedBox(height: 12),
            Text(
              "Duration: ${duration.inMinutes} minutes",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: client == null || service == null
                  ? null
                  : () {
                      final now = DateTime.now();
                      final start = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      );

                      MockAppointments.add(
                        Appointment(
                          dateTime: start,
                          duration: duration,
                          client: client!,
                          service: service!,
                        ),
                      );

                      Navigator.pop(context);
                    },
              child: const Text("Create Appointment"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: items
          .map((e) =>
              DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}