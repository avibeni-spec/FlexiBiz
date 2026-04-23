class Refund {
  final String refundNumber;
  final DateTime issuedAt;
  final String originalReceipt;
  final int amount;
  final String reason;

  const Refund({
    required this.refundNumber,
    required this.issuedAt,
    required this.originalReceipt,
    required this.amount,
    required this.reason,
  });
}