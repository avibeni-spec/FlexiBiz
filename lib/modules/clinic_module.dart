import 'package:flutter/material.dart';
import 'business_module.dart';
 
class ClinicModule extends BusinessModule {
  @override
  Widget buildHomeScreen() {
    return const Center(
      child: Text('מסך קליניקה אסתטית'),
    );
  }
 
  @override
  List<String> getServices() {
    return ['טיפול פנים', 'לייזר', 'הזרקות', 'פילינג'];
  }
 
  @override
  String buildPrompt(Map<String, dynamic> data) {
    return "Create an aesthetic treatment image based on: $data";
  }
}
 