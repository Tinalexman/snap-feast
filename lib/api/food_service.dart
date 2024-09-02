import "package:snapfeast/components/food.dart";
import "package:snapfeast/components/order.dart";
import "package:snapfeast/misc/constants.dart";

import "base.dart";
import "user_service.dart" show token;

export "base.dart";

Future<SnapfeastResponse<List<Food>?>> getRecommendation() async {
  try {
    Response response = await dio.get(
      "/meals/recommendations/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    List<dynamic> data = response.data;
    List<Food> foods = [];

    for (var element in data) {
      String name = element["name"];
      Food food = availableFoods.firstWhere(
        (f) => f.name == name,
        orElse: () => const Food(),
      );
      foods.add(food);
    }

    return SnapfeastResponse(
      message: "Success",
      success: true,
      data: foods,
    );
  } catch (e) {
    log("Get Recommendation Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse> createOrder(int count, int id) async {
  try {
    await dio.post(
      "/orders/",
      data: {
        "quantity": count,
        "meal_id": id,
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    return const SnapfeastResponse(
      message: "Success",
      success: true,
      data: null,
    );
  } catch (e) {
    log("Create Order Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse<List<FoodOrder>?>> getOrders() async {
  try {
    Response response = await dio.get(
      "/orders/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    List<dynamic> data = response.data;
    List<FoodOrder> foods = [];

    for (var element in data) {
      FoodOrder order = FoodOrder(
        foodIndex: (element["meal_id"] as num).toInt(),
        servings: (element["quantity"] as num).toInt(),
      );
      foods.add(order);
    }

    return SnapfeastResponse(
      message: "Success",
      success: true,
      data: foods,
    );
  } catch (e) {
    log("Get Order Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}
