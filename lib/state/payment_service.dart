import '../models/receipt.dart';
import '../models/refund.dart';

class PaymentService {
  static Receipt createReceipt({
    required String client,
    required List<ReceiptItem> items,
    required String paymentMethod,
  }) {
    final total =
        items.fold<int>(0, (sum, i) => sum + i.price);

    return Receipt(
      receiptNumber:
          "REC-${DateTime.now().millisecondsSinceEpoch}",
      issuedAt: DateTime.now(),
      client: client,
      items: items,
      total: total,
      paymentMethod: paymentMethod,
    );
  }

  static Refund refundReceipt({
    required Receipt receipt,
    required String reason,
  }) {
    return Refund(
      refundNumber:
          "REF-${DateTime.now().millisecondsSinceEpoch}",
      issuedAt: DateTime.now(),
      originalReceipt: receipt.receiptNumber,
      amount: receipt.total,
      reason: reason,
    );
  }
}