import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../state/payment_service.dart';
import '../models/receipt.dart';
import '../utils/receipt_pdf_generator.dart';
import '../utils/refund_pdf_generator.dart';
import '../utils/audit_logger.dart';
import '../models/audit_event.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receipt = PaymentService.createReceipt(
      client: "Demo Client",
      items: const [
        ReceiptItem(service: "Haircut", price: 120),
      ],
      paymentMethod: "Credit Card",
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final pdf =
                    ReceiptPdfGenerator.buildReceiptPdf(receipt);

                await Printing.layoutPdf(
                  onLayout: (_) => pdf.save(),
                );

                // ✅ Audit: Receipt
                AuditLogger.log(
                  action: AuditAction.receipt,
                  description:
                      "Receipt ${receipt.receiptNumber} generated for ${receipt.client}",
                );
              },
              child: const Text("Generate Receipt"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final refund =
                    PaymentService.refundReceipt(
                  receipt: receipt,
                  reason: "Customer request",
                );

                final pdf =
                    RefundPdfGenerator.buildRefundPdf(refund);

                await Printing.layoutPdf(
                  onLayout: (_) => pdf.save(),
                );

                // ✅ Audit: Refund
                AuditLogger.log(
                  action: AuditAction.refund,
                  description:
                      "Refund ${refund.refundNumber} created for receipt ${refund.originalReceipt}",
                );
              },
              child: const Text("Refund"),
            ),
          ],
        ),
      ),
    );
  }
}