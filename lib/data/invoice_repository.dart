import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import '../models/invoice.dart';
import 'database_provider.dart';

class InvoiceRepository {
  Future<void> save(Invoice invoice) async {
    final db = await DatabaseProvider.database;

    await db.insert(
      'invoices',
      {
        'invoiceNumber': invoice.invoiceNumber,
        'data': jsonEncode(invoice.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Invoice>> fetchAll() async {
    final db = await DatabaseProvider.database;

    final rows = await db.query(
      'invoices',
      orderBy: 'invoiceNumber DESC',
    );

    return rows
        .map(
          (r) => Invoice.fromJson(
            jsonDecode(r['data'] as String),
          ),
        )
        .toList();
  }

  Future<List<Invoice>> search(String query) async {
    final all = await fetchAll();
    final q = query.toLowerCase();

    return all.where((i) {
      return i.client.toLowerCase().contains(q) ||
          i.invoiceNumber.toLowerCase().contains(q);
    }).toList();
  }
}