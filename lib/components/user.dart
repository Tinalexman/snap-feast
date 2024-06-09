import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String image;
  final String email;
  final String lastName;
  final String firstName;
  final int age;

  const User({
    this.id = "",
    this.image = "",
    this.firstName = "",
    this.lastName = "",
    this.age = 18,
    this.email = "",
  });

  @override
  List<Object> get props => [id];
}
