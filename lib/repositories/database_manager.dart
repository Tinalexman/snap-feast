import 'package:get_it/get_it.dart';
import 'package:snapfeast/repositories/order_repository.dart';
import 'package:snapfeast/repositories/transaction_repository.dart';
import 'package:snapfeast/repositories/user_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static Future<void> init() async {
    Database database = await openDatabase(
      "snapfeast.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
   CREATE TABLE ${UserRepository.userTable} (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     serverID TEXT NOT NULL,
     image TEXT NOT NULL,
     email TEXT NOT NULL,
     firstName TEXT NOT NULL,
     lastName TEXT NOT NULL,
     age INTEGER NOT NULL
   )
 ''');

        await db.execute('''
   CREATE TABLE ${OrderRepository.ordersTable} (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     timestamp INTEGER NOT NULL,
     foodIndex INTEGER NOT NULL,
     servings INTEGER NOT NULL
   )
 ''');

        await db.execute('''
   CREATE TABLE ${TransactionRepository.transactionsTable} (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     timestamp INTEGER NOT NULL,
     type INTEGER NOT NULL,
     amount INTEGER NOT NULL
   )
 ''');
      },
    );
    GetIt.I.registerSingleton<Database>(database);
    GetIt.I.registerLazySingleton<UserRepository>(() => UserRepository());
    GetIt.I.registerLazySingleton<OrderRepository>(() => OrderRepository());
    GetIt.I.registerLazySingleton<TransactionRepository>(
        () => TransactionRepository());
  }
}
