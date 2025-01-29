import 'package:flutter/foundation.dart';
import 'package:money_app/core/db/db_tables/user_amount_table.dart';
import 'package:money_app/core/db/db_tables/user_transaction_history_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseService {
  static const _databaseName = 'pet_app_db';
  static const _databaseVersion = 1;

  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    final String databasePath;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      databasePath = 'my_web.db';
    } else {
      // Get the documents directory.
      final documentsDirectory = await getApplicationDocumentsDirectory();
      // Construct the path to the database file.
      databasePath = join(documentsDirectory.path, _databaseName);
    }
    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await _createAmountTable(db);
    await _createTransactionHistoryTable(db);
  }

  Future<void> _createAmountTable(Database db) async {
    await db.execute('''
    CREATE TABLE ${UserAmountTable().table} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserAmountTable().amount} INTEGER NOT NULL
    )
    ''');
  }

  Future<void> _createTransactionHistoryTable(Database db) async {
    await db.execute('''
    CREATE TABLE ${UserTransactionHistoryTable().table} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserTransactionHistoryTable().transactionType} TEXT NOT NULL,
      ${UserTransactionHistoryTable().amount} INTEGER NOT NULL
    )
  ''');
  }

  /// wont be functional here
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final Map<int, Function(Database)> migrationFunctions = {};

    if (newVersion <= oldVersion) {
      return;
    }

    for (int i = oldVersion + 1; i <= newVersion; i++) {
      final migrationFunction = migrationFunctions[i];
      if (migrationFunction == null) {
        throw Exception('Error: Migration function for version $i not found.');
      }
      migrationFunction(db);
    }
  }
}
