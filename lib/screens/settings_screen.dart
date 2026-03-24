import 'package:flutter/material.dart';
import '../theme/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0D0D0D),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "הגדרות",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20),

            _SettingsItem(
              icon: Icons.person_outline,
              title: "פרופיל עסק",
            ),
            _SettingsItem(
              icon: Icons.notifications_none,
              title: "התראות",
            ),
            _SettingsItem(
              icon: Icons.color_lens_outlined,
              title: "עיצוב ומראה",
            ),
            _SettingsItem(
              icon: Icons.lock_outline,
              title: "פרטיות ואבטחה",
            ),
            _SettingsItem(
              icon: Icons.info_outline,
              title: "אודות ${AppStrings.appName}",
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SettingsItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
        ],
      ),
    );
  }
}
