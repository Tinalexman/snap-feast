import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/repositories/base_repository.dart';

class OrderRepository extends BaseRepository<FoodOrder> {
  static const String ordersTable = "Orders";

  @override
  String get table => ordersTable;

  @override
  Future<FoodOrder> fromJson(Map<String, dynamic> map) async {
    return FoodOrder(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"]),
      foodIndex: map["index"],
      servings: map["servings"],
    );
  }

  @override
  Future<Map<String, dynamic>> toJson(FoodOrder value) async {
    return {
      'index': value.foodIndex,
      'servings': value.servings,
      'timestamp': value.timestamp.millisecondsSinceEpoch,
    };
  }
}
