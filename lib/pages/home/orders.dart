import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {

  @override
  Widget build(BuildContext context) {

    Food food = ref.watch(foodProvider);
    Iterable<String> foodComponents = food.components.keys;
    Iterable<String> foodNutrition = food.nutritionalInfo.keys;
    List<String> foodIngredients = food.ingredients;
    List<String> foodAllergen = food.allergenInfo;
    List<String> foodPairings = food.pairings;
    int count = ref.watch(foodCountProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Text(
                  food.name,
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${currency()} ${format(food.price)}",
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      TextSpan(
                        text: " per serving",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.r,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "${food.rating.toStringAsFixed(1)} of 5",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.h),
                Container(
                  width: 250.r,
                  height: 250.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: AssetImage(food.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (count > 0) {
                          ref.watch(foodCountProvider.notifier).state--;
                        }
                      },
                      child: Container(
                        width: 32.r,
                        height: 32.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.remove_rounded,
                          color: p100,
                          size: 26.r,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      count.toString(),
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    SizedBox(width: 20.w),
                    GestureDetector(
                      onTap: () => ref.watch(foodCountProvider.notifier).state++,
                      child: Container(
                        width: 32.r,
                        height: 32.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: p100,
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 26.r,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Food Description",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  food.description,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Components",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: List.generate(
                    foodComponents.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${foodComponents.elementAt(index)}:",
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              TextSpan(
                                text:
                                    " ${food.components[foodComponents.elementAt(index)]}",
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Taste",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  food.taste,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ingredients",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: List.generate(
                    foodIngredients.length,
                    (index) => SizedBox(
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodIngredients[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nutritional Information (per serving)",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: List.generate(
                    foodNutrition.length,
                    (index) => SizedBox(
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${foodNutrition.elementAt(index)}:",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " ${food.nutritionalInfo[foodNutrition.elementAt(index)]}",
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Allergen Information",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: List.generate(
                    foodAllergen.length,
                    (index) => SizedBox(
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodAllergen[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recommended Pairings",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  children: List.generate(
                    foodPairings.length,
                    (index) => SizedBox(
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodPairings[index],
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: count == 0 ? -50.h : 10.h,
            left: 0.w,
            right: 0.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(390.w, 50.h),
                backgroundColor: p100,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.h),
                ),
              ),
              onPressed: () {
                context.router.pushNamed(Pages.home);
              },
              child: Text(
                "Pay ${currency()} ${formatRawAmount(food.price * count)}",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
