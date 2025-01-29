import 'package:money_app/core/db/db_tables/user_amount_table.dart';
import 'package:money_app/core/db/db_tables/user_transaction_history_table.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/models/local_models/local_transaction_model.dart';

class DatabaseOperations {
  final Database database;

  DatabaseOperations({required this.database});

  /// -------------------- DB OPERATIONS [UserAmountTable] -------------------

  Future<bool> saveMoneyFirstTime() async {
    var row = {UserAmountTable().amount: 100000};

    final Database db = database.database;
    await db.insert(UserAmountTable().table, row);

    return Future.value(true);
  }

  Future<int> getUserBalance() async {
    final Database db = database.database;
    final list = await db.query(UserAmountTable().table);
    return list[0][UserAmountTable().amount] as int;
  }

  /// -------------------- DB OPERATIONS [UserTransactionHistoryTable] -------------------

  Future<bool> saveSendMoneyTransaction(int amount) async {
    var currentBalance = await getUserBalance();
    var row = {UserAmountTable().amount: currentBalance - amount};

    /// update total amount
    final Database db = database.database;
    await db.update(
      UserAmountTable().table,
      row,
      where: '${UserAmountTable().id} = ?',
      whereArgs: [1],
    );

    /// add transaction
    var transaction = {
      UserTransactionHistoryTable().amount: amount,
      UserTransactionHistoryTable().transactionType: "debited"
    };
    await db.insert(UserTransactionHistoryTable().table, transaction);

    return Future.value(true);
  }

  Future<bool> saveAddMoneyTransaction(int money) async {
    var currentBalance = await getUserBalance();
    var row = {UserAmountTable().amount: currentBalance + money};

    /// update total amount
    final Database db = database.database;
    await db.update(
      UserAmountTable().table,
      row,
      where: '${UserAmountTable().id} = ?',
      whereArgs: [1],
    );

    /// add transaction
    var transaction = {
      UserTransactionHistoryTable().amount: money,
      UserTransactionHistoryTable().transactionType: "credited"
    };
    await db.insert(UserTransactionHistoryTable().table, transaction);

    return Future.value(true);
  }

  Future<List<LocalTransactionModel>> getTransactionHistory() async {
    try {
      final response =
          await database.query(UserTransactionHistoryTable().table);

      final List<LocalTransactionModel> list = response.isNotEmpty
          ? response.map((e) => LocalTransactionModel.fromJson(e)).toList()
          : [];

      return list;
    } catch (e) {
      throw Exception();
    }
  }
}
