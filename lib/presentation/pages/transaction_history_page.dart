import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/color_schemes.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/domain/helpers/transaction_history_page_helper.dart';
import 'package:money_app/presentation/cubits/transaction_history_page/transaction_history_page_cubit.dart';

import '../common_widgets/app_bar.dart';

class TransactionHistoryPage extends StatelessWidget {
  static const String routeName = '/transactions_history_page';

  const TransactionHistoryPage({super.key});

  void _getTransactionHistory(BuildContext context) {
    context.read<TransactionHistoryPageCubit>().getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    _getTransactionHistory(context);
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<TransactionHistoryPageCubit, BaseState>(
        builder: (_, state) {
          if (state is GetTransactionHistorySuccess) {
            if (state.list.isNotEmpty) {
              return _listView(context, state.list);
            } else {
              return _viewNoData(context);
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _listView(BuildContext context, List<Transaction> list) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: list.length,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      itemBuilder: (_, index) {
        return _item(context, list[index]);
      },
    );
  }

  Widget _item(BuildContext context, Transaction transaction) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.borderColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transaction.type == EnumTransactionType.credited
                ? context.translations.credited
                : context.translations.debited,
            style: context.textTheme.bodyLarge!.copyWith(
              color: transaction.type == EnumTransactionType.credited
                  ? Colors.greenAccent
                  : Colors.redAccent,
            ),
          ),
          Text(
            'Rs.${transaction.amount}',
            style: context.textTheme.bodyLarge!.copyWith(
              color: transaction.type == EnumTransactionType.credited
                  ? Colors.greenAccent
                  : Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }

  Widget _viewNoData(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.playlist_remove,
            size: 60,
            color: context.textTheme.labelMedium!.color,
          ),
          const SizedBox(height: 12),
          Text(
            context.translations.noTransactions,
            style: context.textTheme.labelMedium!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBarWidget(
      title: context.translations.transactions,
    );
  }
}
