import 'package:flutter/cupertino.dart';
import 'package:money_app/core/extensions/context_extension.dart';

enum EnumTransactionType {
  debited,
  credited,
}

extension ExtEnumTransactionType on EnumTransactionType {
  static EnumTransactionType getType(String type) {
    switch (type) {
      case 'credited':
        return EnumTransactionType.credited;

      default:
        return EnumTransactionType.debited;
    }
  }

  String getLocalized(BuildContext context) {
    switch (this) {
      case EnumTransactionType.debited:
        return context.translations.debited;

      case EnumTransactionType.credited:
        return context.translations.credited;
    }
  }
}
