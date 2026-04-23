import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../models/refund.dart';

class RefundPdfGenerator {
  static pw.Document buildRefundPdf(Refund refund) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Column(
          children: [
            pw.Text("REFUND",
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold)),
            pw.Text(
                "Refund #: ${refund.refundNumber}"),
            pw.Text(
                "Original Receipt: ${refund.originalReceipt}"),
            pw.Text("Date: ${refund.issuedAt}"),
            pw.Divider(),
            pw.Text("Amount Refunded: ₪${refund.amount}"),
            pw.Text("Reason: ${refund.reason}"),
          ],
        ),
      ),
    );

    return pdf;
  }
}