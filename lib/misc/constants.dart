import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


const Color p100 = Color(0xFF393939);
const Color p150 = Color.fromRGBO(57, 57, 57, 0.7);
const Color p200 = Color(0xFF885465);
const Color p300 = Color(0xFFA96C7B);
const Color p400 = Color(0xFFE38C79);
const Color p500 = Color(0xFFFFBC6C);
const Color p600 = Color(0xFFF9F871);

const Color neutral2 = Color.fromARGB(35, 152, 152, 152);

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
  static String get register => "register";
  static String get login => "login";
  static String get camera => "camera";
  static String get home => "home";
  static String get details => "account-details";
}


const String openCameraDialog = "You are about to use the camera. "
"Please make sure you are in a well lit environment. "
"Remove all hats and glasses.";

const String openGalleryDialog = "You are about to select an image from your device. "
"Please choose an image that shows your face well. "
"Make sure you are not wearing hats or glasses.";


const Map<String, dynamic> availableFoods = {
  "Jollof & Fried Rice with Chicken": "assets/images/jf rice.jpg",
  "Amala with Goat Meat": "assets/images/amala.jpg",
  "Porridge with Vegetables": "assets/images/porridge.jpg",
  "White Rice & Beans and Fried Stew": "assets/images/white rice.jpg",
  "Yam and Fried Eggs": "assets/images/yam.jpeg",
  "Pounded Yam with Egusi Soup": "assets/images/pounded yam.jpg",
  "Spaghetti Bolognese with Sauce": "assets/images/spag.jpg",
  "Chicken & Chips": "assets/images/c and c.jpg",
  "Fruit Salad": "assets/images/salad.jpg",
};