import 'package:money_app/core/db/database_service.dart';
import 'package:money_app/core/shared_preference.dart';

abstract class AuthLocalDataSource {
  Future<void> updateAuthStatus();

  Future<bool> userAuthStatus();

  Future<bool> logoutUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseService db;

  AuthLocalDataSourceImpl({required this.db});

  @override
  Future<bool> userAuthStatus() {
    return Future.value(SharedAccess().getBool(PreferenceKeys.authStatus));
  }

  @override
  Future<void> updateAuthStatus() async {
    SharedAccess().storeBool(PreferenceKeys.authStatus, true);
    return Future.value();
  }

  @override
  Future<bool> logoutUser() async {
    SharedAccess().storeBool(PreferenceKeys.authStatus, false);
    return Future.value(true);
  }
}
