import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/domain/repositories/auth_repo.dart';

class LoginUserUseCase extends UseCase<bool, LoginUserParams> {
  final AuthRepo repository;

  LoginUserUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(LoginUserParams params) async {
    return await repository.loginUser(params);
  }
}

class LoginUserParams {
  final String userName;
  final String password;

  LoginUserParams({
    required this.userName,
    required this.password,
  });

  Map<String, String> toMap() {
    Map<String, String> map = {};

    map['username'] = userName;
    map['password'] = password;

    return map;
  }
}
