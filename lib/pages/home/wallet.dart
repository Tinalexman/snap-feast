import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/components/transaction.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  @override
  Widget build(BuildContext context) {
    double amount = ref.watch(walletProvider);
    List<Transaction> transactions = ref.watch(transactionsProvider);

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
          "Wallet",
          style: context.textTheme.headlineSmall!.copyWith(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 390.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: p100,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: "Montserrat",
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "${currency()} ${formatRawAmount(amount)}",
                    style: context.textTheme.displayMedium!.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Last Funded: ${formatDateRaw(DateTime.now())}",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontFamily: "Montserrat",
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(390.w, 50.h),
                backgroundColor: p100,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.h),
                ),
              ),
              onPressed: () => context.router.pushNamed(Pages.deposit),
              child: Text(
                "Deposit",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transactions",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: transactions.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (_, index) {
                        Transaction transaction = transactions[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32.r,
                              height: 32.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: p100,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                transaction.type == TransactionType.credit
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction.type == TransactionType.debit ? "Debit" : "Credit"} of ${currency()} ${formatRawAmount(transaction.amount)}",
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: transaction.type ==
                                            TransactionType.credit
                                        ? Colors.green
                                        : Colors.red,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  formatDateRaw(transaction.timestamp),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 20.h),
                      itemCount: transactions.length,
                    )
                  : Center(
                      child: Text(
                        "No transactions yet",
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
