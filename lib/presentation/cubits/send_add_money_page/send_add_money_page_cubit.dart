import 'package:money_app/core/base_cubit/base_cubit.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/domain/usecases/add_money_use_case.dart';
import 'package:money_app/domain/usecases/get_user_balance_use_case.dart';

import '../../../core/base_usecase/usecase.dart';
import '../../../domain/usecases/send_money_use_case.dart';

part 'send_add_money_page_state.dart';

class SendAddMoneyPageCubit extends BaseCubit {
  final GetUserBalanceUseCase _getUserBalanceUseCase;
  final AddMoneyUseCase _addMoneyUseCase;
  final SendMoneyUseCase _sendMoneyUseCase;

  SendAddMoneyPageCubit({
    required GetUserBalanceUseCase getUserBalanceUseCase,
    required AddMoneyUseCase addMoneyUseCase,
    required SendMoneyUseCase sendMoneyUseCase,
  })  : _getUserBalanceUseCase = getUserBalanceUseCase,
        _addMoneyUseCase = addMoneyUseCase,
        _sendMoneyUseCase = sendMoneyUseCase,
        super(SendAddMoneyPageInitialState());

  Future<void> getUserBalance() async {
    try {
      emit(const LoadingState());

      final response = await _getUserBalanceUseCase.call(NoParams());
      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(GetUserBalance(success));
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<void> addMoney(int amount) async {
    try {
      emit(const LoadingState());

      final response = await _addMoneyUseCase.call(amount);
      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(AddMoneySuccess(success));
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<void> sendMoney(int amount) async {
    try {
      emit(const LoadingState());

      final response = await _sendMoneyUseCase.call(amount);
      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(SendMoneySuccess(success));
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
