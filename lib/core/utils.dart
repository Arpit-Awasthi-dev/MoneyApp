import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_app/core/theme/app_colors.dart';

import 'base_cubit/base_state.dart';

removeFocus(BuildContext context) {
  FocusManager.instance.primaryFocus!.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

class LogLevel {
  static const info = 800;
  static const warning = 900;
  static const error = 1000;
}

Widget buildLoader(BuildContext context, BaseState state) {
  if (state is LoadingState) {
    return GestureDetector(
      onTap: () {
        return;
      },
      child: Container(
        color: Colors.black.withOpacity(0.2),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.deepBlue,
        ),
      ),
    );
  }
  return const SizedBox();
}

void snackBar(BuildContext context, String text) async {
  final snack = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
