import 'package:flutter/material.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/theme/color_schemes.dart';

import '../../core/theme/app_colors.dart';

class LoginParams {
  String userName = '';
  String password = '';
}

Widget txtFormField({
  required BuildContext context,
  FocusNode? focusNode,
  required String label,
  required TextInputAction textInputAction,
  required String? Function(String) validator,
  required VoidCallback onFieldSubmitted,
}) {
  return TextFormField(
    focusNode: focusNode,
    keyboardType: TextInputType.text,
    textInputAction: textInputAction,
    textCapitalization: TextCapitalization.sentences,
    style: context.textTheme.bodyMedium,
    decoration: InputDecoration(
      isDense: true,
      label: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
            TextSpan(
              text: ' *',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.red,
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
    onFieldSubmitted: (String? value) {
      if (value == null) return;
      onFieldSubmitted();
    },
    validator: (String? value) {
      if (value == null) return null;
      return validator(value);
    },
  );
}
