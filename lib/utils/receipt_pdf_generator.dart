import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../models/receipt.dart';

class ReceiptPdfGenerator {
  static pw.Document buildReceiptPdf(Receipt receipt) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Column(
          children: [
            pw.Text("RECEIPT",
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold)),
            pw.Text(
                "Receipt #: ${receipt.receiptNumber}"),
            pw.Text(
                "Date: ${receipt.issuedAt.toString()}"),
            pw.Divider(),
            pw.Text("Client: ${receipt.client}"),
            pw.SizedBox(height: 12),
            pw.Column(
              children: receipt.items.map((i) {
                return pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(i.service),
                    pw.Text("₪${i.price}"),
                  ],
                );
              }).toList(),
            ),
            pw.Divider(),
            pw.Text("TOTAL: ₪${receipt.total}"),
            pw.Text(
                "Payment Method: ${receipt.paymentMethod}"),
          ],
        ),
      ),
    );

    return pdf;
  }
}
