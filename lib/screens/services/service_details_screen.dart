import 'package:flutter/material.dart';
import 'booking_screen.dart';
 
class ServiceDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final int price;
 
  const ServiceDetailsScreen({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // תמונה זמנית
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.spa,
                size: 100,
                color: Colors.pink,
              ),
            ),
 
            const SizedBox(height: 20),
 
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
 
            const SizedBox(height: 10),
 
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
 
            const SizedBox(height: 20),
 
            Text(
              "מחיר: $price ₪",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
 
            const Spacer(),
 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(
                        serviceName: name,
                        price: price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "קבע תור",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 