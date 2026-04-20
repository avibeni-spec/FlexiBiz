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

  bool get isEmpty => items.isEmpty;
}