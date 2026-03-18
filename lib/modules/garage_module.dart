import 'package:flutter/material.dart';
import 'business_module.dart';
 
class GarageModule extends BusinessModule {
  @override
  Widget buildHomeScreen() {
    return const Center(
      child: Text('מסך מוסך'),
    );
  }
 
  @override
  List<String> getServices() {
    return ['טיפול 10,000', 'בלמים', 'צמיגים', 'מיזוג'];
  }
 
  @override
  String buildPrompt(Map<String, dynamic> data) {
    return "Create a car repair image based on: $data";
  }
}
 