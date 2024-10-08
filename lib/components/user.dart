import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String lastName;
  final String firstName;
  final int age;

  const User({
    this.firstName = "",
    this.lastName = "",
    this.age = 18,
    this.email = "",
  });

  String get fullName => "$lastName $firstName";

  @override
  List<Object> get props => [email];
}
