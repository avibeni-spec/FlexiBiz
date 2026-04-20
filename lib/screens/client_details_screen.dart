import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatelessWidget {
  final String name;
  final String phone;

  const ClientDetailsScreen({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // ✅ קריטי
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ───────── Header ─────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    BackButton(color: Colors.white),
                    _BrandTitle(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white24,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ───────── Client Info ─────────
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 32),

                // ───────── Actions ─────────
                Row(
                  children: [
                    _ActionButton(
                      icon: Icons.call,
                      label: "Call",
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _ActionButton(
                      icon: Icons.message,
                      label: "Message",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ───────── Activity ─────────
                const Text(
                  "Recent Activity",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),

                const _ActivityItem(
                  title: "Hair Coloring",
                  subtitle: "10:30 • Jan 22",
                ),
                const _ActivityItem(
                  title: "Haircut",
                  subtitle: "12:00 • Dec 18",
                ),
                const _ActivityItem(
                  title: "Styling",
                  subtitle: "09:30 • Dec 01",
                ),

                const SizedBox(height: 96),

                // ───────── CTA ─────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("New Appointment"),
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
      ),
    );
  }
}

// ───────── Action Button ─────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────── Activity Item ─────────
class _ActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ActivityItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ───────── Brand Title ─────────
class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}