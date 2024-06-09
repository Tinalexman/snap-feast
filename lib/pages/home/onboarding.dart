import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    animation = Tween<Offset>(
      begin: Offset(0, 3.h),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    Future.delayed(
        const Duration(milliseconds: 500), () => controller.forward());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: fade,
            child: Container(
              width: 390.w,
              height: 450.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/food.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(180.r, 20.r),
                  bottomLeft: Radius.elliptical(300.r, 50.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          SlideTransition(
            position: animation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover our food world",
                    style: context.textTheme.displaySmall!.copyWith(
                      color: p100,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "EXPERIENCE THE MOST DELICIOUS FOODS WITH US",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: p150,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.router.pushReplacementNamed(Pages.register),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: p100,
                      fixedSize: Size(170.w, 50.h),
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat"
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
