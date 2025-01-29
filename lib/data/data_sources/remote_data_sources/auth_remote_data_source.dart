import '../../../core/network/api_service.dart';
import '../../../domain/usecases/login_user_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<bool> loginUser(LoginUserParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> loginUser(LoginUserParams params) async {
    /// if api throws exception, true wont be returned
    /// we just checking if post is successful here
    await client.post('auth/login', params.toMap());
    return true;
  }
}
