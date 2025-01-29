import 'package:dartz/dartz.dart';
import 'package:money_app/core/base_usecase/failures.dart';
import 'package:money_app/data/data_sources/local_data_sources/money_local_data_source.dart';
import 'package:money_app/domain/repositories/auth_repo.dart';

import '../../core/error_utils.dart';
import '../../core/network/network_info.dart';
import '../../domain/usecases/login_user_use_case.dart';
import '../data_sources/local_data_sources/auth_local_data_source.dart';
import '../data_sources/remote_data_sources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final MoneyLocalDataSource moneyLocalDataSource;

  AuthRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.moneyLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> loginUser(LoginUserParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.loginUser(params);
        await localDataSource.updateAuthStatus();

        /// ADD money first time
        await moneyLocalDataSource.saveMoneyFirstTime();

        return Right(response);
      } catch (e) {
        final failure = handleFailure(e);
        return Left(Failure(failure));
      }
    } else {
      return const Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      final response = await localDataSource.logoutUser();
      return Right(response);
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> userAuthStatus() async {
    try {
      final response = await localDataSource.userAuthStatus();
      return Right(response);
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }
}
