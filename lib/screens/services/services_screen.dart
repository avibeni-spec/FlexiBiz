import 'package:flutter/material.dart';
import 'service_details_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "name": "תספורת גבר",
        "price": 80,
        "duration": "30 דק׳",
        "description": "תספורת מקצועית כולל עיצוב זקן",
      },
      {
        "name": "פדיקור",
        "price": 120,
        "duration": "45 דק׳",
        "description": "טיפול מלא בכפות הרגליים",
      },
      {
        "name": "מניקור",
        "price": 90,
        "duration": "40 דק׳",
        "description": "עיצוב ציפורניים מקצועי",
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("שירותים"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                // פעולה תתווסף בהמשך
              },
              child: const Text(
                "הוסף שירות",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: services.isEmpty
              ? const _EmptyServicesState()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width < 600
                        ? 1
                        : width < 1000
                            ? 2
                            : 3;

                    return GridView.builder(
                      itemCount: services.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final service = services[index];

                        return _ServiceCard(
                          name: service["name"] as String,
                          price: service["price"] as int,
                          duration: service["duration"] as String,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ServiceDetailsScreen(
                                  name: service["name"] as String,
                                  description:
                                      service["description"] as String,
                                  price: service["price"] as int,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String name;
  final int price;
  final String duration;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.name,
    required this.price,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              "$price ₪ • $duration",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyServicesState extends StatelessWidget {
  const _EmptyServicesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "עדיין לא הוגדרו שירותים",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 8),
          Text(
            "הוסף שירות ראשון כדי שלקוחות יוכלו להזמין תורים.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}