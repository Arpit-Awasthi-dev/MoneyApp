import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/app_colors.dart';
import 'package:money_app/core/utils.dart';
import 'package:money_app/presentation/cubits/login_page/login_page_cubit.dart';
import 'package:money_app/presentation/cubits/user/user_cubit.dart';

import '../../../domain/helpers/login_page_helper.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginParams _loginParams = LoginParams();
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  void _onClickLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginPageCubit>().loginUser(_loginParams);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _rootUI(),
          _viewLoader(),
          _addListeners(),
        ],
      ),
    );
  }

  Widget _addListeners() {
    return BlocListener<LoginPageCubit, BaseState>(
      listener: (_, state) {
        if (state is LoginSuccess) {
          context.read<UserCubit>().getUserAuthStatus();
        } else if (state is FailedState) {
          snackBar(context, state.message);
        }
      },
      child: const SizedBox(),
    );
  }

  Widget _rootUI() {
    return SafeArea(
      child: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _txtFieldUserName(),
                  const SizedBox(height: 16),
                  _textFieldPassword(),
                  const SizedBox(height: 28),
                  _btnLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _txtFieldUserName() {
    return txtFormField(
      context: context,
      label: context.translations.username,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.length < 3) {
          return context.translations.errUsername;
        }
        _loginParams.userName = value;
        return null;
      },
      onFieldSubmitted: () {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _textFieldPassword() {
    return txtFormField(
      context: context,
      focusNode: _passwordFocusNode,
      label: context.translations.password,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.length < 3) {
          return context.translations.errPassword;
        }
        _loginParams.password = value;
        return null;
      },
      onFieldSubmitted: () {
        _onClickLogin();
      },
    );
  }

  Widget _btnLogin() {
    return GestureDetector(
      onTap: () {
        _onClickLogin();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 76),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.deepBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          context.translations.login,
          style: context.textTheme.bodyLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _viewLoader() {
    return BlocBuilder<LoginPageCubit, BaseState>(
      builder: (_, state) {
        return buildLoader(context, state);
      },
    );
  }
}
