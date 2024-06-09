import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/food.dart';
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
  late Food recommendedFood;

  @override
  void initState() {
    super.initState();
    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int index = random.nextInt(availableFoods.length);
    recommendedFood = availableFoods[index];

    Future.delayed(
      const Duration(milliseconds: 500),
      () => ref.watch(foodProvider.notifier).state = recommendedFood,
    );
  }

  @override
  Widget build(BuildContext context) {
    String lastName = ref.watch(userProvider).lastName;

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
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                if(ref.watch(foodProvider) != recommendedFood) {
                  ref.watch(foodCountProvider.notifier).state = 0;
                }
                ref.watch(foodProvider.notifier).state = recommendedFood;
                ref.watch(dashboardIndex.notifier).state = 1;
              },
              child: Container(
                height: 200.h,
                width: 390.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                    image: AssetImage(recommendedFood.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 390.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      alignment: Alignment.center,
                      child: Column(
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
                            recommendedFood.name,
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
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
                itemBuilder: (_, index) => FoodDisplay(food: availableFoods[index]),
                separatorBuilder: (_, __) => SizedBox(width: 20.w),
                itemCount: availableFoods.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

