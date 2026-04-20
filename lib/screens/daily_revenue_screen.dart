import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';

class DailyRevenueScreen extends StatelessWidget {
  final DateTime day;

  const DailyRevenueScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final payments = MockAppointments.all.where((a) {
      return a.status == AppointmentStatus.paid &&
          a.dateTime.year == day.year &&
          a.dateTime.month == day.month &&
          a.dateTime.day == day.day;
    }).toList();

    final total =
        payments.fold<int>(0, (sum, a) => sum + a.price);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: Text(
          "${day.day}/${day.month}/${day.year}",
        ),
        backgroundColor: const Color(0xFF0D0D0D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: payments.isEmpty
            ? const Center(
                child: Text(
                  "No payments this day",
                  style: TextStyle(color: Colors.white54),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total: ₪$total",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (_, index) {
                        final a = payments[index];
                        return Container(
                          margin:
                              const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                a.timeLabel,
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "${a.client} • ${a.service}",
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                "₪${a.price}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}