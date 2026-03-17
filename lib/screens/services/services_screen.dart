import 'package:flutter/material.dart';
import '../../widgets/service_card.dart';
import 'service_details_screen.dart';
 
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "name": "תספורת גבר",
        "description": "תספורת מקצועית כולל עיצוב זקן",
        "price": 80,
      },
      {
        "name": "פדיקור",
        "description": "טיפול מלא בכפות הרגליים",
        "price": 120,
      },
      {
        "name": "מניקור",
        "description": "עיצוב ציפורניים מקצועי",
        "price": 90,
      },
    ];
 
    return Scaffold(
      appBar: AppBar(
        title: const Text("השירותים שלנו"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
 
          return ServiceCard(
            name: service["name"].toString(),
            description: service["description"].toString(),
            price: service["price"] as int,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailsScreen(
                    name: service["name"].toString(),
                    description: service["description"].toString(),
                    price: service["price"] as int,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
 