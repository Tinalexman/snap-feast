import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/transaction.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/misc/widgets.dart';

class DepositPage extends ConsumerStatefulWidget {
  const DepositPage({super.key});

  @override
  ConsumerState<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends ConsumerState<DepositPage> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Deposit",
          style: context.textTheme.headlineSmall!.copyWith(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Funding your account is as easy as walking through a park in a ghost town.",
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: "Montserrat", fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                Text(
                  "Amount",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontFamily: "Montserrat",
                    color: p150,
                  ),
                ),
                SizedBox(height: 5.h),
                SpecialForm(
                  controller: amountController,
                  width: 390.w,
                  height: 40.h,
                  type: TextInputType.number,
                  prefix: Icon(
                    Icons.numbers_rounded,
                    color: p100,
                    size: 18.r,
                  ),
                  hint: "10,000",
                ),
                // SizedBox(height: 20.h),
                // Text(
                //   "Card Number",
                //   style: context.textTheme.bodyMedium!.copyWith(
                //     fontFamily: "Montserrat",
                //     color: p150,
                //   ),
                // ),
                // SizedBox(height: 5.h),
                // SpecialForm(
                //   controller: numberController,
                //   width: 390.w,
                //   height: 40.h,
                //   type: TextInputType.number,
                //   prefix: Icon(
                //     Icons.numbers_rounded,
                //     color: p100,
                //     size: 18.r,
                //   ),
                //   hint: "0000 0000 0000 0000",
                // ),
                // SizedBox(height: 20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Expiry Date",
                //           style: context.textTheme.bodyMedium!.copyWith(
                //             fontFamily: "Montserrat",
                //             color: p150,
                //           ),
                //         ),
                //         SizedBox(height: 5.h),
                //         SpecialForm(
                //           controller: expiryController,
                //           width: 150.w,
                //           height: 40.h,
                //           type: TextInputType.number,
                //           prefix: Icon(
                //             Icons.numbers_rounded,
                //             color: p100,
                //             size: 18.r,
                //           ),
                //           hint: "DD / YY",
                //         )
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "CVV",
                //           style: context.textTheme.bodyMedium!.copyWith(
                //             fontFamily: "Montserrat",
                //             color: p150,
                //           ),
                //         ),
                //         SizedBox(height: 5.h),
                //         SpecialForm(
                //           controller: cvvController,
                //           width: 150.w,
                //           height: 40.h,
                //           type: TextInputType.number,
                //           prefix: Icon(
                //             Icons.numbers_rounded,
                //             color: p100,
                //             size: 18.r,
                //           ),
                //           hint: "123",
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: 150.h),
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
                    double? amount = double.tryParse(amountController.text);
                    if(amount == null) return;

                    Transaction transaction = Transaction(
                      timestamp: DateTime.now(),
                      type: TransactionType.credit,
                      amount: amount,
                    );

                    ref.watch(walletProvider.notifier).state += amount;
                    ref.watch(transactionsProvider.notifier).state.add(transaction);
                    context.router.pop();
                  },
                  child: Text(
                    "Proceed",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
