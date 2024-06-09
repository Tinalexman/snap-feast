import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime timestamp;

  const Transaction({
    this.id = "",
    required this.timestamp,
    required this.type,
    this.amount = 0.0,
  });

  @override
  List<Object?> get props => [id];
}

enum TransactionType {
  credit,
  debit,
}
