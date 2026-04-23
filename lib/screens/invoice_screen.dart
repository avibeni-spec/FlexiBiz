import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../state/mock_appointments.dart';
import '../state/invoice_archive.dart';
import '../models/invoice.dart';
import '../models/business_details.dart';
import '../utils/invoice_pdf_generator.dart';
import '../utils/audit_logger.dart';
import '../models/audit_event.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = MockAppointments.all
        .where((a) => a.status == AppointmentStatus.paid)
        .map((a) => a.client)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Invoices")),
      body: clients.isEmpty
          ? const Center(child: Text("No invoices"))
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (_, index) {
                final client = clients[index];

                return ListTile(
                  title: Text(client),
                  trailing: const Icon(Icons.share),
                  onTap: () async {
                    final items = MockAppointments.all
                        .where((a) =>
                            a.status == AppointmentStatus.paid &&
                            a.client == client)
                        .map(
                          (a) => InvoiceItem(
                            dateTime: a.dateTime,
                            service: a.service,
                            durationMinutes:
                                a.duration.inMinutes,
                            price: a.price,
                          ),
                        )
                        .toList();

                    if (items.isEmpty) return;

                    final invoice = Invoice(
                      invoiceNumber:
                          "INV-${DateTime.now().millisecondsSinceEpoch}",
                      issueDate: DateTime.now(),
                      client: client,
                      from: items.first.dateTime,
                      to: items.last.dateTime,
                      items: items,
                    );

                    // ✅ שמירה לארכיון
                    await InvoiceArchive.add(invoice);

                    // ✅ Audit: Invoice created
                    AuditLogger.log(
                      action: AuditAction.invoice,
                      description:
                          "Invoice ${invoice.invoiceNumber} created for $client",
                    );

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
                        await InvoicePdfGenerator.buildInvoicePdf(
                      invoice,
                      business,
                    );

                    await Printing.sharePdf(
                      bytes: await pdf.save(),
                      filename:
                          "${invoice.invoiceNumber}.pdf",
                    );

                    // ✅ Audit: Invoice shared
                    AuditLogger.log(
                      action: AuditAction.invoiceShared,
                      description:
                          "Invoice ${invoice.invoiceNumber} shared",
                    );
                  },
                );
              },
            ),
    );
  }
}