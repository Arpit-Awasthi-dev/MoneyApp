import '../../../core/db/db_tables/user_transaction_history_table.dart';

class LocalTransactionModel {
  final int id;
  final int amount;
  final String type;

  LocalTransactionModel({
    required this.id,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        UserTransactionHistoryTable().columnID: id,
        UserTransactionHistoryTable().amount: amount,
        UserTransactionHistoryTable().transactionType: type,
      };

  factory LocalTransactionModel.fromJson(Map<String, dynamic> json) =>
      LocalTransactionModel(
        id: json[UserTransactionHistoryTable().columnID],
        amount: json[UserTransactionHistoryTable().amount],
        type: json[UserTransactionHistoryTable().transactionType],
      );
}
