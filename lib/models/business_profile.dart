import 'business_type.dart';
 
class BusinessProfile {
  final BusinessType type;
  final String name;
  final List<String> services;
  final List<String> colors;
  final Map<String, dynamic> features;
  final String promptTemplate;
 
  BusinessProfile({
    required this.type,
    required this.name,
    required this.services,
    required this.colors,
    required this.features,
    required this.promptTemplate,
  });
}
 