import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/widgets/common.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({
    super.key,
  });

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  late List<String> availableFoods, pickedFoods;

  @override
  void initState() {
    super.initState();

    availableFoods = [
      "Jollof & Fried Rice with Chicken",
      "Amala with Goat Meat",
      "Porridge with Vegetables",
      "White Rice & Beans and Fried Stew",
      "Yam and Fried Eggs",
      "Pounded Yam with Egusi Soup",
      "Spaghetti Bolognese with Sauce",
      "Chicken & Chips",
      "Fruit Salad"
    ];
    pickedFoods = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 63.h,
              ),
              Text(
                "SnapFeast",
                style: context.textTheme.displaySmall!.copyWith(
                  color: p100,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
              Text(
                "Which kind of food do you prefer?",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: p150,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat",
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                height: 500.h,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.w,
                    mainAxisExtent: 230.h,
                  ),
                  itemBuilder: (_, index) {
                    String food = availableFoods[index];
                    bool picked = pickedFoods.contains(food);

                    return Column(
                      children: [
                        if(index % 2 == 1)
                          SizedBox(height: 30.h),
                        GestureDetector(
                          onTap: () {
                            if (picked) {
                              pickedFoods.remove(food);
                            } else {
                              pickedFoods.add(food);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 200.h,
                            width: 390.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: picked ? p100 : Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  food,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                    color: picked ? Colors.white : p100,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if(index % 2 == 0)
                          SizedBox(height: 30.h),
                      ],
                    );
                  },
                  itemCount: availableFoods.length,
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
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
                  "Create Account",
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
