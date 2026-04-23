import '../models/invoice.dart';
import '../data/invoice_repository.dart';

class InvoiceArchive {
  static final InvoiceRepository _repo =
      InvoiceRepository();

  static Future<void> add(Invoice invoice) async {
    await _repo.save(invoice);
  }

  static Future<List<Invoice>> all() async {
    return _repo.fetchAll();
  }

  static Future<List<Invoice>> search(String query) async {
    return _repo.search(query);
  }
}