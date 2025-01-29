import 'package:dartz/dartz.dart';

import '../../core/base_usecase/failures.dart';
import '../entities/transaction.dart';

abstract class MoneyRepo {
  Future<Either<Failure, int>> getUserBalance();

  Future<Either<Failure, bool>> addMoney(int money);

  Future<Either<Failure, bool>> sendMoney(int money);

  Future<Either<Failure, List<Transaction>>> getTransactionHistory();
}
