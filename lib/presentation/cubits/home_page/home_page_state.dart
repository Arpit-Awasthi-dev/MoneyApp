part of 'home_page_cubit.dart';

class HomePageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class GetUserBalanceSuccess extends HomePageInitialState{
  final int balance;
  GetUserBalanceSuccess(this.balance);

  @override
  List<Object?> get props => [balance];
}