import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/domain/helpers/login_page_helper.dart';
import 'package:money_app/domain/usecases/login_user_use_case.dart';

import '../../../core/base_cubit/base_cubit.dart';

part 'login_page_state.dart';

class LoginPageCubit extends BaseCubit {
  final LoginUserUseCase _loginUserUseCase;

  LoginPageCubit({required LoginUserUseCase loginUserUseCase})
      : _loginUserUseCase = loginUserUseCase,
        super(LoginPageInitialState());

  Future<void> loginUser(LoginParams params) async {
    try {
      emit(const LoadingState());
      final response = await _loginUserUseCase.call(LoginUserParams(
        userName: params.userName,
        password: params.password,
      ));

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(LoginSuccess());
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
