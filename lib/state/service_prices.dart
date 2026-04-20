class ServiceConfig {
  final int price;
  final Duration duration;

  const ServiceConfig({
    required this.price,
    required this.duration,
  });

  ServiceConfig copyWith({
    int? price,
    Duration? duration,
  }) {
    return ServiceConfig(
      price: price ?? this.price,
      duration: duration ?? this.duration,
    );
  }
}

class ServicePrices {
  static final Map<String, ServiceConfig> services = {
    "Haircut": const ServiceConfig(
      price: 120,
      duration: Duration(minutes: 30),
    ),
    "Hair Coloring": const ServiceConfig(
      price: 250,
      duration: Duration(minutes: 90),
    ),
    "Styling": const ServiceConfig(
      price: 180,
      duration: Duration(minutes: 45),
    ),
    "Beard Trim": const ServiceConfig(
      price: 80,
      duration: Duration(minutes: 30),
    ),
  };

  static int getPrice(String service) =>
      services[service]?.price ?? 0;

  static Duration getDuration(String service) =>
      services[service]?.duration ?? const Duration(minutes: 30);

  static void updatePrice(String service, int newPrice) {
    final current = services[service];
    if (current != null) {
      services[service] =
          current.copyWith(price: newPrice);
    }
  }

  static void updateDuration(String service, Duration newDuration) {
    final current = services[service];
    if (current != null) {
      services[service] =
          current.copyWith(duration: newDuration);
    }
  }
}