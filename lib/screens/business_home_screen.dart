import 'package:flutter/material.dart';
import '../models/business_type.dart';
 
class BusinessHomeScreen extends StatelessWidget {
  final BusinessType businessType;
 
  const BusinessHomeScreen({super.key, required this.businessType});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(businessTypeLabel(businessType)),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ברוך הבא ל-${businessTypeLabel(businessType)}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
 