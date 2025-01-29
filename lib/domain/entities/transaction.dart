import 'package:money_app/data/models/local_models/local_transaction_model.dart';

import '../helpers/transaction_history_page_helper.dart';

class Transaction {
  final int id;
  final int amount;
  final EnumTransactionType type;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
  });

  factory Transaction.fromLocal(LocalTransactionModel localTransaction) {
    return Transaction(
      id: localTransaction.id,
      amount: localTransaction.amount,
      type: ExtEnumTransactionType.getType(localTransaction.type),
    );
  }
}
