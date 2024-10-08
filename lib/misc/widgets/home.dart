import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/order.dart';
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
        if (ref.watch(foodProvider) != food) {
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
                  colorFilter: ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken,
                  ),
                ),
              ),
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                bottom: 10.h,
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                food.name,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                  color: Colors.white,
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

class FoodOrderReceipt extends StatelessWidget {
  final FoodOrder order;

  const FoodOrderReceipt({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    Food food = availableFoods.firstWhere(
      (element) => element.id == order.foodIndex,
      orElse: () => const Food(),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: neutral2),
      ),
      child: SizedBox(
        height: 160.h,
        child: Column(
          children: [
            Container(
              width: 390.w,
              height: 80.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(food.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(
                right: 10.w,
                top: 5.h,
              ),
              child: Container(
                width: 60.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      food.rating.toStringAsFixed(1),
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.star,
                      size: 20.r,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    food.name,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${currency()} ${format(food.price * order.servings)} (${order.servings} servings)",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
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
