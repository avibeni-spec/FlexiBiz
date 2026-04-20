import 'package:flutter/material.dart';
import '../state/service_prices.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final durations = const [
    Duration(minutes: 30),
    Duration(minutes: 45),
    Duration(minutes: 60),
    Duration(minutes: 90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: const Color(0xFF0D0D0D),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: ServicePrices.services.entries.map((entry) {
          final name = entry.key;
          final config = entry.value;
          final priceController =
              TextEditingController(text: config.price.toString());

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Price
                Row(
                  children: [
                    const Text(
                      "Price ₪",
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF2A2A2A),
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) {
                          final parsed =
                              int.tryParse(value);
                          if (parsed != null) {
                            setState(() {
                              ServicePrices.updatePrice(
                                  name, parsed);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Duration
                Row(
                  children: [
                    const Text(
                      "Duration",
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<Duration>(
                      dropdownColor: const Color(0xFF1A1A1A),
                      value: config.duration,
                      items: durations
                          .map(
                            (d) => DropdownMenuItem(
                              value: d,
                              child: Text(
                                "${d.inMinutes} min",
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            ServicePrices.updateDuration(
                                name, value);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}