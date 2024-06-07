import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


const Color p100 = Color(0xFF393939);
const Color p200 = Color(0xFF885465);
const Color p300 = Color(0xFFA96C7B);
const Color p400 = Color(0xFFE38C79);
const Color p500 = Color(0xFFFFBC6C);
const Color p600 = Color(0xFFF9F871);

// IMAGES USED
// https://www.freepik.com/free-psd/3d-background-with-assortment-gastronomy-dishes_40778967.htm#query=food%20illustration&position=0&from_view=keyword&track=ais_user&uuid=6a9d12f8-7faf-4456-9ba8-3fc48eea5f5f

extension PathExtension on String {
  String get path => "/$this";
}

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  GoRouter get router => GoRouter.of(this);
}

class Pages {
  static String get onboard => "onboarding";

}

