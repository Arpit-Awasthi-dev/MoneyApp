import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';

import '../usecases/login_user_use_case.dart';

abstract class AuthRepo{
  Future<Either<Failure, bool>> userAuthStatus();

  Future<Either<Failure, bool>> loginUser(LoginUserParams params);

  Future<Either<Failure, bool>> logoutUser();
}