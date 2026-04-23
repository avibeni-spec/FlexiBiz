class ReceiptItem {
  final String service;
  final int price;

  const ReceiptItem({
    required this.service,
    required this.price,
  });
}

class Receipt {
  final String receiptNumber;
  final DateTime issuedAt;
  final String client;
  final List<ReceiptItem> items;
  final int total;
  final String paymentMethod;

  const Receipt({
    required this.receiptNumber,
    required this.issuedAt,
    required this.client,
    required this.items,
    required this.total,
    required this.paymentMethod,
  });
}
