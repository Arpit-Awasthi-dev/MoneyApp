import 'package:flutter/material.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/color_schemes.dart';
import 'package:money_app/presentation/pages/send_add_money_page/send_add_money_page.dart';
import 'package:money_app/presentation/pages/transaction_history_page.dart';

import '../../../core/theme/app_colors.dart';
import '../../common_widgets/app_bar.dart';
import 'user_current_balance.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _rootUI(),
      ),
    );
  }

  Widget _rootUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UserCurrentBalance(),
          const SizedBox(height: 60),
          _btnSendAddMoney(),
          const SizedBox(height: 16),
          _btnTransactionHistory(),
        ],
      ),
    );
  }

  Widget _btnSendAddMoney() {
    return GestureDetector(
      onTap: () {
        context.navigator.pushNamed(SendAddMoneyPage.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.deepBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          context.translations.sendAddMoney,
          style: context.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _btnTransactionHistory() {
    return GestureDetector(
      onTap: () {
        context.navigator.pushNamed(TransactionHistoryPage.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorScheme.borderColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          context.translations.sendAddMoney,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBarWidget(
      title: context.translations.yourMoneyApp,
      leading: const Icon(
        Icons.attach_money,
        size: 24,
        color: AppColors.deepBlue,
      ),
    );
  }
}
