import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../state/mock_appointments.dart';
import '../models/invoice.dart';
import '../utils/invoice_pdf_generator.dart';

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
          ? const Center(
              child: Text("No paid appointments"),
            )
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (_, index) {
                final client = clients[index];

                return ListTile(
                  title: Text(client),
                  trailing: const Icon(Icons.picture_as_pdf),
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

                    final pdf =
                        await InvoicePdfGenerator.buildInvoicePdf(
                      invoice,
                    );

                    await Printing.layoutPdf(
                      onLayout: (_) => pdf.save(),
                    );
                  },
                );
              },
            ),
    );
  }
}