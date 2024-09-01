import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/components/transaction.dart';
import 'package:snapfeast/components/user.dart';
import 'package:snapfeast/misc/constants.dart';

const User dummyUser = User(
  firstName: "John",
  lastName: "Doe",
  age: 22,
  email: "johndoe@mail.com",
);

final StateProvider<User> userProvider = StateProvider((ref) => dummyUser);
final StateProvider<int> dashboardIndex = StateProvider((ref) => 0);
final StateProvider<int> foodCountProvider = StateProvider((ref) => 0);
final StateProvider<Food> foodProvider = StateProvider((ref) {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  return availableFoods[random.nextInt(availableFoods.length)];
  // return const Food();
});
final StateProvider<double> walletProvider = StateProvider((ref) => 0.0);
final StateProvider<List<Transaction>> transactionsProvider =
    StateProvider((ref) => []);
final StateProvider<List<FoodOrder>> foodOrdersProvider =
    StateProvider((ref) => []);

void logout(WidgetRef ref) {
  ref.invalidate(foodOrdersProvider);
  ref.invalidate(walletProvider);
  ref.invalidate(transactionsProvider);
  ref.invalidate(foodCountProvider);
  ref.invalidate(foodProvider);
  ref.invalidate(dashboardIndex);
  ref.invalidate(userProvider);
}
