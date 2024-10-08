import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snapfeast/misc/constants.dart';

void showToast(String message, BuildContext context) {
  if(!context.mounted) return;

  HapticFeedback.vibrate();

  AnimatedSnackBar snackBar = AnimatedSnackBar(
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 250.w,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: p100,
          borderRadius: BorderRadius.circular(7.5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Text(
            message,
            style: context.textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Montserrat",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    animationCurve: Curves.ease,
    snackBarStrategy: RemoveSnackBarStrategy(),
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 350),
  );

  snackBar.show(context);
}

void unFocus() => FocusManager.instance.primaryFocus?.unfocus();

String formatRawAmount(double price) => formatAmount(price.toStringAsFixed(0));

String formatAmount(String price) {
  String priceInText = "";
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

String format(double val) =>
    val.toStringAsFixed(val.truncateToDouble() == val ? 0 : 2);

String formatDateRaw(DateTime dateTime, {bool shorten = false}) =>
    formatDate(DateFormat("dd/MM/yyyy").format(dateTime), shorten: shorten);

String currency() => NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

String formatDate(String dateTime, {bool shorten = false}) {
  int firIndex = dateTime.indexOf("/");
  String d = dateTime.substring(0, firIndex);
  int secIndex = dateTime.indexOf("/", firIndex + 1);
  String m = dateTime.substring(firIndex + 1, secIndex);
  String y = dateTime.substring(secIndex + 1);

  return "${month(m, shorten)} ${day(d)}, $y";
}

String month(String val, bool shorten) {
  int month = int.parse(val);
  switch (month) {
    case 1:
      return shorten ? "Jan" : "January";
    case 2:
      return shorten ? "Feb" : "February";
    case 3:
      return shorten ? "Mar" : "March";
    case 4:
      return shorten ? "Apr" : "April";
    case 5:
      return "May";
    case 6:
      return shorten ? "Jun" : "June";
    case 7:
      return shorten ? "Jul" : "July";
    case 8:
      return shorten ? "Aug" : "August";
    case 9:
      return shorten ? "Sep" : "September";
    case 10:
      return shorten ? "Oct" : "October";
    case 11:
      return shorten ? "Nov" : "November";
    default:
      return shorten ? "Dec" : "December";
  }
}

String day(String val) {
  int day = int.parse(val);
  int remainder = day % 10;
  switch (remainder) {
    case 1:
      return (day == 11) ? "${day}th" : "${day}st";
    case 2:
      return (day == 12) ? "${day}th" : "${day}nd";
    case 3:
      return (day == 13) ? "${day}th" : "${day}rd";
    default:
      return "${day}th";
  }
}

String formatDuration(Duration duration) {
  int total = duration.inSeconds;
  int min = total ~/ 60;
  int secs = total - (min * 60);
  return "$min:$secs";
}

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  int i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }
  return hash;
}

bool validateForm(GlobalKey<FormState> formKey) {
  unFocus();
  FormState? currentState = formKey.currentState;
  if (currentState != null) {
    if (!currentState.validate()) return false;

    currentState.save();
    return true;
  }
  return false;
}

String getTimeOfDay() {
  final DateTime now = DateTime.now();
  final int hour = now.hour;

  if (hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour <= 16) {
    return "Good Afternoon";
  }
  return "Good Evening";
}

String roboImage(String id) =>
    "https://gravatar.com/avatar/${fastHash(id).toString()}?s=400&d=robohash&r=x";
