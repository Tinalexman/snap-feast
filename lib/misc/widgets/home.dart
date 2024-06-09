import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';

class FoodDisplay extends ConsumerWidget {
  final Food food;

  const FoodDisplay({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if(ref.watch(foodProvider) != food) {
          ref.watch(foodCountProvider.notifier).state = 0;
        }

        ref.watch(foodProvider.notifier).state = food;
        ref.watch(dashboardIndex.notifier).state = 1;
      },
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.h,
              width: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(food.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 140.h,
                width: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.black54,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  food.name,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${currency()} ${format(food.price)}",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.r,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      food.rating.toStringAsFixed(1),
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
