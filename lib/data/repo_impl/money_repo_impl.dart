import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/domain/repositories/money_repo.dart';

import '../../core/network/network_info.dart';
import '../data_sources/local_data_sources/money_local_data_source.dart';
import '../data_sources/remote_data_sources/money_remote_data_source.dart';

class MoneyRepoImpl implements MoneyRepo {
  final NetworkInfo networkInfo;
  final MoneyRemoteDataSource remoteDataSource;
  final MoneyLocalDataSource localDataSource;

  MoneyRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> addMoney(int money) async {
    try {
      final response = await localDataSource.saveAddMoneyTransaction(money);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionHistory() async {
    try {
      final response = await localDataSource.getTransactionHistory();
      var list = response.map((e) => Transaction.fromLocal(e)).toList();
      return Right(list);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUserBalance() async {
    try {
      final response = await localDataSource.getUserBalance();
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMoney(int money) async {
    try {
      final response = await localDataSource.saveSendMoneyTransaction(money);
      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
