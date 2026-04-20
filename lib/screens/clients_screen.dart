import 'package:flutter/material.dart';
import 'client_details_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  static const List<_Client> _clients = [
    _Client(name: "Sarah Cohen", phone: "052-1234567"),
    _Client(name: "Daniel Levy", phone: "054-9876543"),
    _Client(name: "Noa Shani", phone: "050-4567890"),
    _Client(name: "Itay Green", phone: "053-1112233"),
    _Client(name: "Maya Katz", phone: "058-3344556"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.menu, color: Colors.white),
                _BrandTitle(),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white24,
                ),
              ],
            ),

            const SizedBox(height: 40),

            const Text(
              "Clients",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                itemCount: _clients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final client = _clients[index];
                  return _ClientCard(
                    client: client,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ClientDetailsScreen(
                            name: client.name,
                            phone: client.phone,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  final _Client client;
  final VoidCallback onTap;

  const _ClientCard({
    required this.client,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white70),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    client.phone,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white38,
            ),
          ],
        ),
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

class _Client {
  final String name;
  final String phone;

  const _Client({
    required this.name,
    required this.phone,
  });
}