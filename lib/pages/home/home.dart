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
          ],
        ),
      ),
    );
  }
}
