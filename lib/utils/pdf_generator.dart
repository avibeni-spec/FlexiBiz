import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

import '../models/revenue_report.dart';

class PdfGenerator {
  static Future<pw.Document> buildRevenuePdf(
    RevenueReport report,
  ) async {
    final pdf = pw.Document();

    // Load logo from assets
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
        build: (context) => [
          _header(report, logo),
          pw.SizedBox(height: 24),
          _summary(report),
          pw.SizedBox(height: 24),
          _table(report),
        ],
      ),
    );

    return pdf;
  }

  // ───────── HEADER ─────────

  static pw.Widget _header(
    RevenueReport report,
    pw.ImageProvider logo,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Left: Title
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
              "Revenue Report",
              style: const pw.TextStyle(
                fontSize: 14,
                color: PdfColors.grey700,
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              "From ${_fmtDate(report.from)} to ${_fmtDate(report.to)}",
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),

        // Right: Logo
        pw.Image(
          logo,
          width: 64,
          height: 64,
        ),
      ],
    );
  }

  // ───────── SUMMARY ─────────

  static pw.Widget _summary(RevenueReport report) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            "TOTAL",
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            "₪${report.total}",
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ───────── TABLE ─────────

  static pw.Widget _table(RevenueReport report) {
    return pw.TableHelper.fromTextArray(
      context: null,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: const pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      cellAlignment: pw.Alignment.centerLeft,
      headers: const [
        'Date',
        'Time',
        'Client',
        'Service',
        'Duration',
        'Price',
      ],
      data: report.rows.map((r) {
        return [
          _fmtDate(r.dateTime),
          _fmtTime(r.dateTime),
          r.client,
          r.service,
          '${r.durationMinutes}m',
          '₪${r.price}',
        ];
      }).toList(),
    );
  }

  // ───────── HELPERS ─────────

  static String _fmtDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';

  static String _fmtTime(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}