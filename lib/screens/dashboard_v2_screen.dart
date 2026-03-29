import 'package:flutter/material.dart';

class DashboardV2Screen extends StatelessWidget {
  const DashboardV2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ───────── Header ─────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Colors.white),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.0,
                      ),
                      children: [
                        TextSpan(text: 'Flex'),
                        TextSpan(
                          text: 'O',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(text: 'ra'),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white24,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ───────── Welcome ─────────
              const Text(
                "GOOD MORNING",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your studio is ready for today.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 40),

              // ───────── Bento Grid ─────────
              GridView.count(
                crossAxisCount: isWide ? 2 : 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.4,
                children: const [
                  _StatCard(
                    icon: Icons.calendar_today,
                    value: "8",
                    label: "Today's Appointments",
                  ),
                  _StatCard(
                    icon: Icons.payments,
                    value: "₪450",
                    label: "Revenue Today",
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ───────── Highlight ─────────
              const Text(
                "Next Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 28, backgroundColor: Colors.white24),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sarah Cohen",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "10:30 • Hair Coloring",
                            style: TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    TextButton(onPressed: null, child: const Text("Check In")),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // ───────── CTA ─────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Quick Add Appointment"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFE9C349), size: 30),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}