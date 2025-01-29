import 'package:money_app/core/base_cubit/base_cubit.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/base_usecase/usecase.dart';
import 'package:money_app/domain/entities/transaction.dart';

import '../../../domain/usecases/get_transaction_history_use_case.dart';

part 'transaction_history_page_state.dart';

class TransactionHistoryPageCubit extends BaseCubit {
  final GetTransactionHistoryUseCase _getTransactionHistoryUseCase;

  TransactionHistoryPageCubit({
    required GetTransactionHistoryUseCase getTransactionHistoryUseCase,
  })  : _getTransactionHistoryUseCase = getTransactionHistoryUseCase,
        super(TransactionHistoryPageInitialState());

  Future<void> getTransactionHistory() async {
    try {
      emit(const LoadingState());
      final response = await _getTransactionHistoryUseCase.call(NoParams());
      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (success) {
          emit(GetTransactionHistorySuccess(success));
        },
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
