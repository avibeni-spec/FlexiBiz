import 'package:flutter/material.dart';
 
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "תורים",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
 
            Expanded(
              child: ListView(
                children: const [
                  _AppointmentItem(
                    name: "נועה כהן",
                    service: "תספורת נשים",
                    time: "10:00",
                  ),
                  _AppointmentItem(
                    name: "דנה לוי",
                    service: "פדיקור",
                    time: "11:30",
                  ),
                  _AppointmentItem(
                    name: "רוני ישראלי",
                    service: "עיסוי שוודי",
                    time: "13:00",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
 
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
 
class _AppointmentItem extends StatelessWidget {
  final String name;
  final String service;
  final String time;
 
  const _AppointmentItem({
    required this.name,
    required this.service,
    required this.time,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                service,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            time,
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
 