import 'package:snapfeast/components/user.dart';
import 'package:snapfeast/repositories/base_repository.dart';

class UserRepository extends BaseRepository<User> {
  static const String userTable = "Users";

  @override
  String get table => userTable;

  @override
  Future<User> fromJson(Map<String, dynamic> map) async {
    return User(
      email: map["email"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      age: map["age"],
    );
  }

  @override
  Future<Map<String, dynamic>> toJson(User value) async {
    return {
      'email': value.email,
      'firstName': value.firstName,
      'lastName': value.lastName,
      'age': value.age,
    };
  }

  Future<User?> getMainUser() async {
    List<User> users = await super.getAll();
    return users.isEmpty ? null : users.first;
  }

  Future<void> saveMainUser(User user) async {
    await super.clearAllAndAddAll([user]);
  }
}
