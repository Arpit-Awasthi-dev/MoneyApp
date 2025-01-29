import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';

import '../repositories/auth_repo.dart';

class GetUserAuthStatusUseCase extends UseCase<bool, NoParams> {
  final AuthRepo repository;

  GetUserAuthStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.userAuthStatus();
  }
}
