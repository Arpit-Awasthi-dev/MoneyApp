import 'dart:developer';

import 'package:money_app/core/base_cubit/base_cubit.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/navigation/navigation_service.dart';

import '../../../core/injection_container.dart';
import '../../../core/utils.dart';
import '../../../domain/usecases/get_user_auth_status_use_case.dart';
import '../../../domain/usecases/logout_use_case.dart';

part 'user_state.dart';

class UserCubit extends BaseCubit {
  final GetUserAuthStatusUseCase _getUserAuthStatusUseCase;
  final LogoutUseCase _logOutUseCase;

  UserCubit({
    required GetUserAuthStatusUseCase getUserAuthStatusUseCase,
    required LogoutUseCase logOutUseCase,
  })  : _getUserAuthStatusUseCase = getUserAuthStatusUseCase,
        _logOutUseCase = logOutUseCase,
        super(UserInitialState());

  Future<void> getUserAuthStatus() async {
    try {
      final response = await _getUserAuthStatusUseCase.call(NoParams());
      response.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (success) {
          emit(UserAuthStatus(isLoggedIn: success));
        },
      );
    } catch (e) {
      log('Auth status error', level: LogLevel.error);
    }
  }

  Future<void> logout() async {
    try {
      final response = await _logOutUseCase.call(NoParams());
      response.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (success) {
          var context = sl<NavigationService>().navigatorKey.currentContext;
          if (context != null) {
            context.navigator.popUntil((route) => route.isFirst);
          }
          emit(LogoutUser(logout: success));
        },
      );
    } catch (e) {
      log('Auth status error', level: LogLevel.error);
    }
  }
}
