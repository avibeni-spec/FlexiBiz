import 'package:flutter/material.dart';
import '../models/business_type.dart';
import 'business_home_screen.dart';
 
class BusinessTypeSelectionScreen extends StatelessWidget {
  const BusinessTypeSelectionScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    const types = BusinessType.values;
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('בחר את סוג העסק שלך'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
 
          return ListTile(
            title: Text(
              businessTypeLabel(type),
              textAlign: TextAlign.right,
            ),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BusinessHomeScreen(businessType: type),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
 