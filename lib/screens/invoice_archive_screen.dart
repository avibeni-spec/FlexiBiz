import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../state/invoice_archive.dart';
import '../models/invoice.dart';
import '../models/business_details.dart';
import '../utils/invoice_pdf_generator.dart';

class InvoiceArchiveScreen extends StatefulWidget {
  const InvoiceArchiveScreen({super.key});

  @override
  State<InvoiceArchiveScreen> createState() =>
      _InvoiceArchiveScreenState();
}

class _InvoiceArchiveScreenState
    extends State<InvoiceArchiveScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Archive"),
      ),
      body: Column(
        children: [
          // 🔍 Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by client or invoice #",
              ),
              onChanged: (v) {
                setState(() {
                  query = v;
                });
              },
            ),
          ),

          // 📦 Data
          Expanded(
            child: FutureBuilder<List<Invoice>>(
              future: _loadInvoices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading invoices"),
                  );
                }

                final invoices = snapshot.data ?? [];

                if (invoices.isEmpty) {
                  return const Center(
                    child: Text("No invoices found"),
                  );
                }

                return ListView.builder(
                  itemCount: invoices.length,
                  itemBuilder: (_, i) {
                    final inv = invoices[i];

                    return ListTile(
                      title: Text(inv.client),
                      subtitle: Text(
                        "Invoice ${inv.invoiceNumber} • ₪${inv.total}",
                      ),
                      trailing:
                          const Icon(Icons.picture_as_pdf),
                      onTap: () async {
                        final business = const BusinessDetails(
                          name: "FlexOra",
                          registrationId: "123456789",
                          address: "Tel Aviv, Israel",
                          phone: "+972-50-123-4567",
                          email: "info@flexora.app",
                          footerNote:
                              "Payment due immediately. This invoice is not a tax receipt.",
                        );

                        final pdf =
                            await InvoicePdfGenerator
                                .buildInvoicePdf(
                          inv,
                          business,
                        );

                        await Printing.layoutPdf(
                          onLayout: (_) => pdf.save(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ טוען ומסנן חשבוניות בצורה נכונה
  Future<List<Invoice>> _loadInvoices() async {
    final allInvoices = await InvoiceArchive.all();

    if (query.isEmpty) return allInvoices;

    final q = query.toLowerCase();

    return allInvoices.where((i) {
      return i.client.toLowerCase().contains(q) ||
          i.invoiceNumber.toLowerCase().contains(q);
    }).toList();
  }
}
