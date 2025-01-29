import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/cubits/user/user_cubit.dart';
import 'package:provider/single_child_widget.dart';
import '../presentation/cubits/home_page/home_page_cubit.dart';
import '../presentation/cubits/login_page/login_page_cubit.dart';
import '../presentation/cubits/send_add_money_page/send_add_money_page_cubit.dart';
import '../presentation/cubits/transaction_history_page/transaction_history_page_cubit.dart';
import 'injection_container.dart' as di;

class BlocProviders {
  static List<SingleChildWidget> toGenerateProviders() {
    return [
      BlocProvider(
        create: (_) => di.sl<UserCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<LoginPageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<HomePageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<SendAddMoneyPageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<TransactionHistoryPageCubit>(),
      ),
    ];
  }
}
