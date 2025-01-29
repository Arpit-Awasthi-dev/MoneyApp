import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/domain/repositories/money_repo.dart';

class AddMoneyUseCase extends UseCase<bool, int>{
  final MoneyRepo repository;

  AddMoneyUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(int params)async {
    return await repository.addMoney(params);
  }


}