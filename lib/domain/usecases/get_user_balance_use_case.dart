import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';

import '../repositories/money_repo.dart';

class GetUserBalanceUseCase extends UseCase<int, NoParams>{
  final MoneyRepo repository;

  GetUserBalanceUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(NoParams params) async{
    return await repository.getUserBalance();
  }

}