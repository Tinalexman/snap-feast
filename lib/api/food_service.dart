import "package:snapfeast/components/food.dart";
import "package:snapfeast/components/order.dart";

import "package:snapfeast/misc/constants.dart";

import "base.dart";
export "base.dart";

import "user_service.dart" show token;



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

    for(var element in data) {
      String name = element["name"];
      Food food = availableFoods.firstWhere((f) => f.name == name);
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
