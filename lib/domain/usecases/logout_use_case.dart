import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/domain/repositories/auth_repo.dart';

class LogoutUseCase extends UseCase<bool, NoParams>{
  final AuthRepo repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params)async {
    return await repository.logoutUser();
  }
}