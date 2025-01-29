import 'package:money_app/core/base_cubit/base_cubit.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/base_usecase/usecase.dart';

import '../../../domain/usecases/get_user_balance_use_case.dart';

part 'home_page_state.dart';

class HomePageCubit extends BaseCubit {
  final GetUserBalanceUseCase _getUserBalanceUseCase;

  HomePageCubit({required GetUserBalanceUseCase getUserBalanceUseCase})
      : _getUserBalanceUseCase = getUserBalanceUseCase,
        super(HomePageInitialState());

  Future<void> getUserBalance() async {
    try {
      emit(const LoadingState());

      final response = await _getUserBalanceUseCase.call(NoParams());
      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(GetUserBalanceSuccess(success));
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
