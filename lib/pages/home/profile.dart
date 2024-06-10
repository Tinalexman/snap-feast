import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/user.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/repositories/user_repository.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Food mostOrdered;

  @override
  void initState() {
    super.initState();
    mostOrdered = ref.read(foodProvider);
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider);
    double amount = ref.watch(walletProvider);
    int totalOrders = ref.watch(foodOrdersProvider).length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            ref.watch(dashboardIndex.notifier).state = 0;
            ref.watch(foodCountProvider.notifier).state = 0;
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: p100,
          ),
          iconSize: 26.r,
        ),
        centerTitle: true,
        title: Text(
          "Profile",
          style: context.textTheme.headlineSmall!.copyWith(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: IconButton(
              onPressed: () {
                final UserRepository rep = GetIt.I.get();
                rep.deleteAll();
                context.goNamed(Pages.onboard);
                logout(ref);
              },
              icon: const Icon(Boxicons.bx_log_out, color: p100),
              iconSize: 26.r,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: roboImage(user.image),
                      errorWidget: (_, __, c) => Container(
                        width: 150.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: p100,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      progressIndicatorBuilder: (_, __, c) => Container(
                        width: 150.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: p150,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      imageBuilder: (_, provider) => Container(
                        width: 150.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: neutral2,
                          borderRadius: BorderRadius.circular(15.r),
                          image: DecorationImage(
                            image: provider,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            user.fullName,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Email",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            user.email,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Age",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            user.age.toString(),
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 180.h,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 95.h,
                      crossAxisSpacing: 50.w,
                    ),
                    children: [
                      Column(
                        children: [
                          Text(
                            "Today's Orders",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            totalOrders.toString(),
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Total Orders",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            totalOrders.toString(),
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Wallet Balance",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            "${currency()} ${formatRawAmount(amount)}",
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Total Food Cost",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontFamily: "Montserrat",
                              color: p150,
                            ),
                          ),
                          Text(
                            "${currency()} ${formatRawAmount(amount)}",
                            style: context.textTheme.headlineMedium!.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "Most Ordered Food",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: "Montserrat",
                      color: p150,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 150.h,
                  width: 390.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: AssetImage(mostOrdered.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: 150.h,
                    width: 390.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.black54,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      mostOrdered.name,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
