import 'package:flutter_test/flutter_test.dart';
import 'package:money_app/core/db/database_operations.dart';
import 'package:money_app/core/db/db_tables/user_amount_table.dart';
import 'package:money_app/core/db/db_tables/user_transaction_history_table.dart';
import 'package:money_app/data/models/local_models/local_transaction_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Database database;
  late DatabaseOperations databaseOperations;

  group('Db operations test', () {
    setUpAll(() async {
      database = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
    CREATE TABLE ${UserAmountTable().table} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserAmountTable().amount} INTEGER NOT NULL
    )
    ''');
            await db.execute('''
    CREATE TABLE ${UserTransactionHistoryTable().table} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${UserTransactionHistoryTable().transactionType} TEXT NOT NULL,
      ${UserTransactionHistoryTable().amount} INTEGER NOT NULL
    )
  ''');
          },
        ),
      );

      databaseOperations = DatabaseOperations(database: database);
    });

    test('Initial amount insertion test', () async {
      /// Arrange - done inside method

      /// Act
      bool success = await databaseOperations.saveMoneyFirstTime();

      ///  Assert
      expect(success, true);
    });

    test('Get User Balance test', () async {
      int success = await databaseOperations.getUserBalance();
      expect(success, 100000);
    });

    test('Add money test', () async {
      bool success = await databaseOperations.saveAddMoneyTransaction(1000);
      expect(success, true);
    });

    test('transaction saved test', () async {
      List<LocalTransactionModel> list =
          await databaseOperations.getTransactionHistory();
      expect(1, list.length);
      expect(1000, list.last.amount);
      expect('credited', list.last.type);
    });

    test('send money test', () async {
      bool success = await databaseOperations.saveSendMoneyTransaction(100);
      expect(success, true);
    });

    test('transaction saved test', () async {
      List<LocalTransactionModel> list =
      await databaseOperations.getTransactionHistory();
      expect(2, list.length);
      expect(100, list.last.amount);
      expect('debited', list.last.type);
    });

    test('Get User Balance test', () async {
      int success = await databaseOperations.getUserBalance();
      expect(success, 100000 + 1000 - 100);
    });
  });
}
