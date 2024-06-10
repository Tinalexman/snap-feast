
class Transaction {
  final TransactionType type;
  final double amount;
  final DateTime timestamp;

  const Transaction({
    required this.timestamp,
    required this.type,
    this.amount = 0.0,
  });

}

enum TransactionType {
  credit,
  debit,
}
