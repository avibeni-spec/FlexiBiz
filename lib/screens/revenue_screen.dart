import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../models/revenue_report.dart';
import '../models/revenue_range.dart';
import '../utils/pdf_report_builder.dart';
import '../utils/pdf_generator.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  RevenueRange selectedRange = RevenueRange.week;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final RevenueReport report = PdfReportBuilder.build(
      range: selectedRange,
      anchor: now,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Revenue"),
        backgroundColor: const Color(0xFF0D0D0D),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: report.isEmpty
                ? null
                : () async {
                    // ✅ FIX: await the PDF creation
                    final pdf =
                        await PdfGenerator.buildRevenuePdf(
                      report,
                    );

                    await Printing.layoutPdf(
                      onLayout: (_) => pdf.save(),
                    );
                  },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ───── Range Selector ─────
            Row(
              children: [
                _rangeButton("Day", RevenueRange.day),
                const SizedBox(width: 8),
                _rangeButton("Week", RevenueRange.week),
                const SizedBox(width: 8),
                _rangeButton("Month", RevenueRange.month),
              ],
            ),

            const SizedBox(height: 24),

            // ───── Summary ─────
            Text(
              "Total: ₪${report.total}",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            // ───── Preview List ─────
            Expanded(
              child: report.isEmpty
                  ? const Center(
                      child: Text(
                        "No payments in this range",
                        style:
                            TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: report.rows.length,
                      itemBuilder: (_, i) {
                        final r = report.rows[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF1A1A1A),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${r.dateTime.hour.toString().padLeft(2, '0')}:${r.dateTime.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "${r.client} • ${r.service}",
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                "₪${r.price}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rangeButton(String label, RevenueRange range) {
    final selected = selectedRange == range;

    return GestureDetector(
      onTap: () =>
          setState(() => selectedRange = range),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withOpacity(0.15)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : Colors.white54,
          ),
        ),
      ),
    );
  }
}