import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/misc/widgets.dart';

class FoodOrdersPage extends ConsumerStatefulWidget {
  const FoodOrdersPage({super.key});

  @override
  ConsumerState<FoodOrdersPage> createState() => _FoodOrdersPageState();
}

class _FoodOrdersPageState extends ConsumerState<FoodOrdersPage> {
  @override
  Widget build(BuildContext context) {
    List<FoodOrder> orders = ref.watch(foodOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: p100,
          ),
          iconSize: 26.r,
        ),
        centerTitle: true,
        title: Text(
          "Orders",
          style: context.textTheme.headlineSmall!.copyWith(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            itemBuilder: (_, index) {
              if (index == orders.length) {
                return SizedBox(height: 40.h);
              }

              return FoodOrderReceipt(order: orders[index]);
            },
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
            itemCount: orders.length + 1,
          ),
        ),
      ),
    );
  }
}
