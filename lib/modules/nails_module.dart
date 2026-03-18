import 'package:flutter/material.dart';
import 'business_module.dart';
 
class NailsModule extends BusinessModule {
  @override
  Widget buildHomeScreen() {
    return const Center(
      child: Text('מסך עיצוב ציפורניים'),
    );
  }
 
  @override
  List<String> getServices() {
    return ['ג׳ל', 'אקריל', 'פרנץ׳', 'אומברה'];
  }
 
  @override
  String buildPrompt(Map<String, dynamic> data) {
    return "Create a nail design image based on: $data";
  }
}
 