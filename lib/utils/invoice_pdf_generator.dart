import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

import '../models/invoice.dart';
import '../models/business_details.dart';

class InvoicePdfGenerator {
  static Future<pw.Document> buildInvoicePdf(
    Invoice invoice,
    BusinessDetails business,
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
        footer: (_) => _footer(business),
        build: (_) => [
          _header(invoice, business, logo),
          pw.SizedBox(height: 20),
          _clientSection(invoice),
          pw.SizedBox(height: 16),
          _table(invoice),
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
    BusinessDetails business,
    pw.ImageProvider logo,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              business.name,
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text("Invoice #${invoice.invoiceNumber}"),
            pw.Text("Issued: ${_fmtDate(invoice.issueDate)}"),
            pw.SizedBox(height: 6),
            pw.Text("Reg ID: ${business.registrationId}"),
            pw.Text(business.address),
            pw.Text("☎ ${business.phone}"),
            pw.Text("✉ ${business.email}"),
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

  // ───────── TOTAL ─────────

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

  // ───────── FOOTER ─────────

  static pw.Widget _footer(BusinessDetails business) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        business.footerNote,
        style: const pw.TextStyle(
          fontSize: 9,
          color: PdfColors.grey600,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  // ───────── HELPERS ─────────

  static String _fmtDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/"
      "${d.year}";

  static String _fmtDateTime(DateTime d) =>
      "${_fmtDate(d)} "
      "${d.hour.toString().padLeft(2, '0')}:"
      "${d.minute.toString().padLeft(2, '0')}";
}
