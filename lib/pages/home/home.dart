import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  String recommendedFood = "";

  @override
  void initState() {
    super.initState();

    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    int index = random.nextInt(availableFoods.length);
    recommendedFood = availableFoods.keys.elementAt(index);
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
              "Hey, $lastName",
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
            Container(
              height: 200.h,
              width: 390.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  image: AssetImage(availableFoods[recommendedFood]),
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
                    child: Text(
                      recommendedFood,
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
