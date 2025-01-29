import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/color_schemes.dart';
import 'package:money_app/presentation/cubits/send_add_money_page/send_add_money_page_cubit.dart';

import '../../../core/theme/app_colors.dart';
import '../../cubits/home_page/home_page_cubit.dart';

class UserCurrentBalance extends StatefulWidget {
  const UserCurrentBalance({super.key});

  @override
  State<UserCurrentBalance> createState() => _UserCurrentBalanceState();
}

class _UserCurrentBalanceState extends State<UserCurrentBalance> {
  bool isBalanceHidden = true;

  void _changeBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }

  void _getUserBalance() {
    context.read<HomePageCubit>().getUserBalance();
  }

  @override
  void initState() {
    super.initState();
    _getUserBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _rootUI(),
        BlocListener<SendAddMoneyPageCubit, BaseState>(
          listener: (_, state) {
            if (state is AddMoneySuccess || state is SendMoneySuccess) {
              _getUserBalance();
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }

  Widget _rootUI() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.borderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.translations.currentBalance,
            style: context.textTheme.bodyMedium,
          ),
          BlocBuilder<HomePageCubit, BaseState>(
            builder: (_, state) {
              if (state is GetUserBalanceSuccess) {
                return _viewBalance(state.balance);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _viewBalance(int balance) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          isBalanceHidden ? '* * * * * *' : 'Rs.$balance',
          style: context.textTheme.bodyLarge,
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            _changeBalanceVisibility();
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Icon(
              isBalanceHidden ? Icons.visibility : Icons.visibility_off,
              color: AppColors.deepBlue,
            ),
          ),
        ),
      ],
    );
  }
}
