class InvoiceItem {
  final DateTime dateTime;
  final String service;
  final int durationMinutes;
  final int price;

  const InvoiceItem({
    required this.dateTime,
    required this.service,
    required this.durationMinutes,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toIso8601String(),
        'service': service,
        'durationMinutes': durationMinutes,
        'price': price,
      };

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      dateTime: DateTime.parse(json['dateTime']),
      service: json['service'],
      durationMinutes: json['durationMinutes'],
      price: json['price'],
    );
  }
}

class Invoice {
  final String invoiceNumber;
  final DateTime issueDate;
  final String client;
  final DateTime from;
  final DateTime to;
  final List<InvoiceItem> items;

  const Invoice({
    required this.invoiceNumber,
    required this.issueDate,
    required this.client,
    required this.from,
    required this.to,
    required this.items,
  });

  int get total =>
      items.fold<int>(0, (sum, i) => sum + i.price);

  Map<String, dynamic> toJson() => {
        'invoiceNumber': invoiceNumber,
        'issueDate': issueDate.toIso8601String(),
        'client': client,
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
        'items': items.map((i) => i.toJson()).toList(),
      };

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceNumber: json['invoiceNumber'],
      issueDate: DateTime.parse(json['issueDate']),
      client: json['client'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      items: (json['items'] as List)
          .map((i) => InvoiceItem.fromJson(i))
          .toList(),
    );
  }
}