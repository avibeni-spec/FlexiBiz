import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

import '../models/invoice.dart';

class InvoicePdfGenerator {
  static Future<pw.Document> buildInvoicePdf(
    Invoice invoice,
  ) async {
    final pdf = pw.Document();

    final logoBytes =
        (await rootBundle.load('assets/flexora_icon.png'))
            .buffer
            .asUint8List();
    final logo = pw.MemoryImage(logoBytes);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
        ),
        build: (_) => [
          _header(invoice, logo),
          pw.SizedBox(height: 20),
          _clientSection(invoice),
          pw.SizedBox(height: 16),
          _table(invoice),
          pw.SizedBox(height: 12),
          pw.Divider(),
          _total(invoice),
        ],
      ),
    );

    return pdf;
  }

  // ───────── HEADER ─────────

  static pw.Widget _header(
    Invoice invoice,
    pw.ImageProvider logo,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "FlexOra",
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "INVOICE",
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Text("Invoice #: ${invoice.invoiceNumber}"),
            pw.Text("Issue Date: ${_fmtDate(invoice.issueDate)}"),
          ],
        ),
        pw.Image(logo, width: 64),
      ],
    );
  }

  // ───────── CLIENT ─────────

  static pw.Widget _clientSection(Invoice invoice) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Text(
        "Client: ${invoice.client}",
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  // ───────── TABLE ─────────

  static pw.Widget _table(Invoice invoice) {
    return pw.TableHelper.fromTextArray(
      context: null,
      headers: const [
        "Date",
        "Service",
        "Duration",
        "Price",
      ],
      headerStyle:
          pw.TextStyle(fontWeight: pw.FontWeight.bold),
      data: invoice.items.map((i) {
        return [
          _fmtDateTime(i.dateTime),
          i.service,
          "${i.durationMinutes} min",
          "₪${i.price}",
        ];
      }).toList(),
    );
  }

  static pw.Widget _total(Invoice invoice) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        "TOTAL: ₪${invoice.total}",
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/"
      "${d.year}";

  static String _fmtDateTime(DateTime d) =>
      "${_fmtDate(d)} "
      "${d.hour.toString().padLeft(2, '0')}:"
      "${d.minute.toString().padLeft(2, '0')}";
}