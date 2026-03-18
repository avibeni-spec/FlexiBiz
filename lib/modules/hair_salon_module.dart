import 'package:flutter/material.dart';
import 'business_module.dart';
 
class HairSalonModule extends BusinessModule {
  @override
  Widget buildHomeScreen() {
    return const Center(child: Text('מסך מספרה'));
  }
 
  @override
  List<String> getServices() {
    return ['תספורת', 'פן', 'צבע', 'החלקה'];
  }
 
  @override
  String buildPrompt(Map<String, dynamic> data) {
    return "Create a hairstyle image based on: $data";
  }
}
 