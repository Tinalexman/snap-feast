import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/api/food_service.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/misc/widgets.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  Food? recommendedFood;
  bool loadingOrders = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        recommendedFoodOfTheDay();
        foodOrderList();
      },
    );
  }

  void showErrorMessage(String msg) => showToast(msg, context);

  Future<void> recommendedFoodOfTheDay() async {
    SnapfeastResponse<List<Food>?> food = await getRecommendation();
    if (!food.success || food.data == null) {
      showErrorMessage("Unable to get the recommended food. Retrying");
      recommendedFoodOfTheDay();
      return;
    }

    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int index = random.nextInt(food.data!.length);
    recommendedFood = food.data![index];
    setState(() {});
  }

  Future<void> foodOrderList() async {
    SnapfeastResponse<List<FoodOrder>?> orders = await getOrders();
    if (!orders.success || orders.data == null) {
      showErrorMessage("Unable to get the food orders. Retrying");
      foodOrderList();
      return;
    }

    loadingOrders = false;
    ref.watch(foodOrdersProvider.notifier).state = orders.data!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String lastName = ref.watch(userProvider).lastName;
    List<FoodOrder> orders = ref.watch(foodOrdersProvider);

    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              "Hey, $lastName 😇",
              style: context.textTheme.bodyLarge!.copyWith(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              getTimeOfDay(),
              style: context.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                if (recommendedFood == null) return;

                if (ref.watch(foodProvider) != recommendedFood) {
                  ref.watch(foodCountProvider.notifier).state = 0;
                }
                ref.watch(foodProvider.notifier).state = recommendedFood!;
                ref.watch(dashboardIndex.notifier).state = 1;
              },
              child: Container(
                height: 170.h,
                width: 390.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: recommendedFood != null
                      ? DecorationImage(
                          image: AssetImage(recommendedFood!.image),
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                            Colors.black45,
                            BlendMode.darken,
                          ),
                        )
                      : null,
                ),
                child: recommendedFood == null
                    ? loader
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Recommended meal of the day",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          Text(
                            recommendedFood!.name,
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Categories",
              style: context.textTheme.bodyLarge!.copyWith(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) =>
                    FoodDisplay(food: availableFoods[index]),
                separatorBuilder: (_, __) => SizedBox(width: 20.w),
                itemCount: availableFoods.length,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Orders",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (orders.length > 1)
                  GestureDetector(
                    onTap: () => context.router.pushNamed(Pages.orders),
                    child: Text(
                      "View All",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        color: p400,
                        decoration: TextDecoration.underline,
                        decorationColor: p400,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            if (orders.isNotEmpty) FoodOrderReceipt(order: orders.first),
            if (loadingOrders || orders.isEmpty)
              SizedBox(
                width: 390.w,
                height: 160.h,
                child: Center(
                  child: loadingOrders
                      ? whiteLoader
                      : Text(
                          "No orders yet",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
              ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
