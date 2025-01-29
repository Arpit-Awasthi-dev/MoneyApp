import 'package:money_app/core/db/database_operations.dart';
import 'package:money_app/core/db/database_service.dart';
import 'package:money_app/data/models/local_models/local_transaction_model.dart';

abstract class MoneyLocalDataSource {
  Future<bool> saveMoneyFirstTime();

  Future<int> getUserBalance();

  Future<bool> saveSendMoneyTransaction(int money);

  Future<bool> saveAddMoneyTransaction(int money);

  Future<List<LocalTransactionModel>> getTransactionHistory();
}

class MoneyLocalDataSourceImpl implements MoneyLocalDataSource {
  final DatabaseService db;

  MoneyLocalDataSourceImpl({required this.db});

  @override
  Future<bool> saveMoneyFirstTime() async {
    final response = await DatabaseOperations(database: await db.database)
        .saveMoneyFirstTime();
    return response;
  }

  @override
  Future<int> getUserBalance() async {
    return await DatabaseOperations(database: await db.database)
        .getUserBalance();
  }

  @override
  Future<bool> saveAddMoneyTransaction(int money) async {
    return await DatabaseOperations(database: await db.database)
        .saveAddMoneyTransaction(money);
  }

  @override
  Future<bool> saveSendMoneyTransaction(int money) async {
    return await DatabaseOperations(database: await db.database)
        .saveSendMoneyTransaction(money);
  }

  @override
  Future<List<LocalTransactionModel>> getTransactionHistory() async {
    return await DatabaseOperations(database: await db.database)
        .getTransactionHistory();
  }
}
