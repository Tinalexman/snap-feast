import 'package:snapfeast/components/transaction.dart';
import 'package:snapfeast/repositories/base_repository.dart';

class TransactionRepository extends BaseRepository<Transaction> {
  static const String transactionsTable = "Transactions";

  @override
  String get table => transactionsTable;

  @override
  Future<Transaction> fromJson(Map<String, dynamic> map) async {
    return Transaction(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"]),
      type: map["type"] == 0 ? TransactionType.credit : TransactionType.debit,
      amount: (map["amount"] as num).toDouble(),
    );
  }

  @override
  Future<Map<String, dynamic>> toJson(Transaction value) async {
    return {
      'timestamp': value.timestamp.millisecondsSinceEpoch,
      'type' : value.type == TransactionType.credit ? 0 : 1,
      'amount' : value.amount.toInt(),
    };
  }
}
