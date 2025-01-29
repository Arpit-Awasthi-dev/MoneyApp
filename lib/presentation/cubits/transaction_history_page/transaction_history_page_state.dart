part of 'transaction_history_page_cubit.dart';

class TransactionHistoryPageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class GetTransactionHistorySuccess extends TransactionHistoryPageInitialState {
  final List<Transaction> list;

  GetTransactionHistorySuccess(this.list);
}
