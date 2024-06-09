import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/transaction.dart';
import 'package:snapfeast/components/user.dart';
import 'package:uuid/uuid.dart';

const User dummyUser = User(
  id: "DUMMY",
  image: "Dummy Image",
  firstName: "John",
  lastName: "Doe",
  age: 22,
  email: "johndoe@mail.com",
);

final StateProvider<User> userProvider = StateProvider((ref) => dummyUser);
final StateProvider<int> dashboardIndex = StateProvider((ref) => 0);
final StateProvider<int> foodCountProvider = StateProvider((ref) => 0);
final StateProvider<Food> foodProvider = StateProvider((ref) => const Food());
final StateProvider<double> walletProvider = StateProvider((ref) => 0.0);
final StateProvider<List<Transaction>> transactionsProvider =
StateProvider((ref) {
  Uuid uuid = const Uuid();

  return [
    Transaction(
        timestamp: DateTime.now(),
        type: TransactionType.credit,
        id: uuid.v4(),
        amount: 10000
    ),
    Transaction(
        timestamp: DateTime.now(),
        type: TransactionType.debit,
        id: uuid.v4(),
        amount: 6700
    ),
    Transaction(
        timestamp: DateTime.now(),
        type: TransactionType.credit,
        id: uuid.v4(),
        amount: 1000
    ),
    Transaction(
        timestamp: DateTime.now(),
        type: TransactionType.debit,
        id: uuid.v4(),
        amount: 5000
    ),
  ];
});

void logout(WidgetRef ref) {
  ref.invalidate(walletProvider);
  ref.invalidate(transactionsProvider);
  ref.invalidate(foodCountProvider);
  ref.invalidate(foodProvider);
  ref.invalidate(dashboardIndex);
  ref.invalidate(userProvider);
}
