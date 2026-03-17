class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final Duration duration;
 
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.duration,
  });
}