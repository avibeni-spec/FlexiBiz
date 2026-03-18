import 'package:flutter/material.dart';
import '../models/business_type.dart';
import 'hair_salon_module.dart';
import 'clinic_module.dart';
import 'garage_module.dart';
import 'nails_module.dart';
 
abstract class BusinessModule {
  Widget buildHomeScreen();
  List<String> getServices();
  String buildPrompt(Map<String, dynamic> data);
}
 
class BusinessModuleFactory {
  static BusinessModule create(BusinessType type) {
    switch (type) {
      case BusinessType.hairSalon:
        return HairSalonModule();
      case BusinessType.clinic:
        return ClinicModule();
      case BusinessType.garage:
        return GarageModule();
      case BusinessType.nails:
        return NailsModule();
    }
  }
}
 