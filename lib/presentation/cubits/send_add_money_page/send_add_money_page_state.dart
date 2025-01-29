part of 'send_add_money_page_cubit.dart';

class SendAddMoneyPageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class GetUserBalance extends SendAddMoneyPageInitialState {
  final int balance;

  GetUserBalance(this.balance);

  @override
  List<Object?> get props => [balance];
}

class AddMoneySuccess extends SendAddMoneyPageInitialState {
  final bool success;

  AddMoneySuccess(this.success);
}

class AddMoneyFailed extends SendAddMoneyPageInitialState {}

class SendMoneySuccess extends SendAddMoneyPageInitialState {
  final bool success;

  SendMoneySuccess(this.success);
}
