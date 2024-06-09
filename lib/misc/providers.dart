import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/user.dart';

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

void logout(WidgetRef ref) {
  ref.invalidate(foodProvider);
  ref.invalidate(dashboardIndex);
  ref.invalidate(userProvider);
}
