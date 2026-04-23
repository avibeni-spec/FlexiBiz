import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path =
        join(await getDatabasesPath(), 'flexora.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE invoices(
            invoiceNumber TEXT PRIMARY KEY,
            data TEXT
          )
        ''');
      },
    );

    return _db!;
  }
}