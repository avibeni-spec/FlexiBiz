import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';
import 'revenue_screen.dart';

class DashboardV2Screen extends StatelessWidget {
  const DashboardV2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // ───────── Revenue Calculations ─────────
    const int pricePerAppointment = 120;

    final paidAppointments = MockAppointments.all
        .where((a) => a.status == AppointmentStatus.paid)
        .toList();

    final totalRevenue =
        paidAppointments.length * pricePerAppointment;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ───────── Header ─────────
              const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 32),

              // ───────── Revenue Card ─────────
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RevenueScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Revenue Today",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₪$totalRevenue",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${paidAppointments.length} paid",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ───────── Quick Stats ─────────
              _QuickStat(
                label: "Appointments Today",
                value: MockAppointments.all
                    .where((a) =>
                        a.status == AppointmentStatus.scheduled ||
                        a.status == AppointmentStatus.checkedIn)
                    .length
                    .toString(),
              ),

              const SizedBox(height: 12),

              _QuickStat(
                label: "Completed",
                value: paidAppointments.length.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────── Quick Stat Widget ─────────
class _QuickStat extends StatelessWidget {
  final String label;
  final String value;

  const _QuickStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}