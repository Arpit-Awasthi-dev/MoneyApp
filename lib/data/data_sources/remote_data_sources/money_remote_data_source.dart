import 'package:money_app/core/network/api_service.dart';
import 'package:money_app/domain/entities/transaction.dart';

abstract class MoneyRemoteDataSource{
  Future<bool> sendMoney(int money);

  Future<bool> addMoney(int money);

  Future<List<Transaction>> getTransactionHistory();
}

class MoneyRemoteDataSourceImpl implements MoneyRemoteDataSource{
  final ApiService client;

  MoneyRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> addMoney(int money) {
    // TODO: implement addMoney
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionHistory() {
    // TODO: implement getTransactionHistory
    throw UnimplementedError();
  }

  @override
  Future<bool> sendMoney(int money) {
    // TODO: implement sendMoney
    throw UnimplementedError();
  }

}