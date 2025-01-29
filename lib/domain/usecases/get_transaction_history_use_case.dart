import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/domain/repositories/money_repo.dart';

class GetTransactionHistoryUseCase extends UseCase<List<Transaction>, NoParams>{
  final MoneyRepo repository;

  GetTransactionHistoryUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params)async {
    return await repository.getTransactionHistory();
  }
}