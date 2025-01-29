import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/color_schemes.dart';
import 'package:money_app/core/utils.dart';
import 'package:money_app/presentation/cubits/send_add_money_page/send_add_money_page_cubit.dart';

import '../../../core/theme/app_colors.dart';
import '../../common_widgets/app_bar.dart';

class SendAddMoneyPage extends StatefulWidget {
  static const String routeName = '/send_add_money_page';

  const SendAddMoneyPage({super.key});

  @override
  State<SendAddMoneyPage> createState() => _SendAddMoneyPageState();
}

class _SendAddMoneyPageState extends State<SendAddMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  bool _sendingMoney = false;
  final _controller = TextEditingController();

  void _getBalance() {
    context.read<SendAddMoneyPageCubit>().getUserBalance();
  }

  void _addMoney() {
    if (_formKey.currentState!.validate()) {
      var amount = int.parse(_controller.text);
      context.read<SendAddMoneyPageCubit>().addMoney(amount);
    }
  }

  void _sendMoney() {
    _sendingMoney = true;
    if (_formKey.currentState!.validate()) {
      var amount = int.parse(_controller.text);
      context.read<SendAddMoneyPageCubit>().sendMoney(amount);
    }
    _sendingMoney = false;
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Stack(
        children: [
          BlocConsumer<SendAddMoneyPageCubit, BaseState>(
            buildWhen: (prev, curr) {
              return curr is GetUserBalance;
            },
            builder: (_, state) {
              if (state is GetUserBalance) {
                return _rootUI(context, state.balance);
              }
              return const SizedBox();
            },
            listener: (_, state) {
              if (state is AddMoneySuccess) {
                snackBar(context, context.translations.moneyAdded);
                _getBalance();
              } else if (state is SendMoneySuccess) {
                snackBar(context, context.translations.moneySent);
                _getBalance();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _rootUI(BuildContext context, int balance) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _viewBalance(balance),
              _amountFieldAndSendAddBtn(balance),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewBalance(int balance) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      child: Text(
        'Rs.$balance',
        style: context.textTheme.bodyLarge!.copyWith(
          color: Colors.greenAccent,
        ),
      ),
    );
  }

  Widget _amountFieldAndSendAddBtn(int balance) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _txtFieldAmount(balance),
          const SizedBox(height: 60),
          _viewSendAddMoney(),
        ],
      ),
    );
  }

  Widget _txtFieldAmount(int balance) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      style: context.textTheme.bodyMedium,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      decoration: InputDecoration(
        isDense: true,
        label: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: context.translations.amount,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: context.colorScheme.borderColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.deepBlue),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.borderColor,
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null) return null;
        if (value.isEmpty) {
          return context.translations.errCanNotBeEmpty;
        } else if (_sendingMoney) {
          try {
            int amount = int.parse(value);
            if (amount > balance) {
              return context.translations.errAmountCannotBeGreater;
            }
          } catch (e) {
            return context.translations.errInvalidEntry;
          }
        }
        return null;
      },
    );
  }

  Widget _viewSendAddMoney() {
    return Row(
      children: [
        _btnAddMoney(),
        const SizedBox(width: 16),
        _btnSendMoney(),
      ],
    );
  }

  Widget _btnAddMoney() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _addMoney();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.greenAccent),
          ),
          child: Text(
            context.translations.add,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _btnSendMoney() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _sendMoney();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.deepBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            context.translations.send,
            style: context.textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBarWidget(
      title: context.translations.sendAddMoney,
    );
  }
}
