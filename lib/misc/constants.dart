import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:snapfeast/components/food.dart';

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

  static String get deposit => "deposit";

  static String get orders => "orders";

  static String get faceCapture => "face-capture";
}

const String openCameraDialog = "You are about to use the camera. "
    "Please make sure you are in a well lit environment. "
    "Remove all hats and glasses.";

const String openGalleryDialog =
    "You are about to select an image from your device. "
    "Please choose an image that shows your face well. "
    "Make sure you are not wearing hats or glasses.";

const List<Food> availableFoods = [
  Food(
    name: "Jollof & Fried Rice with Chicken",
    image: "assets/images/jf rice.jpg",
    price: 2500,
    rating: 4.5,
    description: "Enjoy the perfect fusion of West African and Asian flavors "
        "with our Jollof and Fried Rice Delight with Chicken! This mouthwatering dish "
        "combines the spicy and savory flavors of Jollof rice with the crispy and "
        "aromatic textures of fried rice, all mixed with juicy and tender chicken.",
    taste:
        "The combination of Jollof and fried rice creates a delightful harmony of "
        "flavors and textures, with the spicy and savory flavors of the Jollof "
        "rice balanced by the crispy and aromatic textures of the fried rice. "
        "The chicken adds a juicy and tender element to the dish, making it a "
        "complete and satisfying meal.",
    components: {
      "Jollof Rice":
          "Our Jollof rice is cooked to perfection with a blend of spices, tomatoes, "
              "and onions, giving it a rich and slightly spicy flavor.",
      "Fried Rice":
          "Our fried rice is cooked with a mix of vegetables, spices, and herbs, "
              "then stir-fried to create a crispy and savory texture that complements the Jollof rice perfectly.",
      "Chicken":
          "Our chicken is marinated in a blend of spices and herbs, then grilled to perfection to create a "
              "juicy and tender experience that pairs well with the Jollof and fried rice."
    },
    ingredients: [
      "Jollof rice",
      "Fried rice",
      "Chicken breast or thighs",
      "Spices and herbs (marinade)",
      "Vegetables (onions, bell peppers, carrots)",
      "Palm oil or vegetable oil",
    ],
    nutritionalInfo: {
      "Calories": "600",
      "Protein": "40g",
      "Fat": "30g",
      "Saturated Fat": "12g",
      "Carbohydrates": "60g",
      "Fiber": "5g",
      "Sodium": "500mg",
    },
    allergenInfo: ["May contain traces of nuts or soy"],
    pairings: ["Vegetable salad", "Fried plantains", "Grilled chicken skewers"],
  ),
  Food(
    name: "Amala with Goat Meat",
    image: "assets/images/amala.jpg",
    price: 1800,
    rating: 4.0,
    description:
        "Indulge in the rich flavors of Nigeria with our Amala and Goat Meat Delight! "
        "Amala, a traditional Yoruba dish, is made from fermented cassava flour or plantain flour, "
        "giving it a unique texture and flavor. Our Amala is carefully prepared to achieve "
        "the perfect balance of texture and taste.",
    components: {
      "Goat Meat":
          "Our slow-cooked goat meat is tender and juicy, with a rich flavor that "
              "complements the Amala perfectly. The goat meat is marinated in a blend of spices and herbs, "
              "then slow-cooked to perfection to create a fall-off-the-bone tender experience.",
    },
    taste:
        "The combination of Amala and goat meat creates a delightful harmony of flavors and textures. "
        "The slightly bitter taste of Amala is balanced by the rich flavor of the goat meat, while the "
        "texture of the Amala provides a satisfying contrast to the tender meat.",
    ingredients: [
      "Fermented cassava flour or plantain flour (Amala)",
      "Goat meat",
      "Spices and herbs (marinade)",
      "Vegetables (onions, bell peppers, tomatoes)",
      "Palm oil or vegetable oil",
    ],
    nutritionalInfo: {
      "Calories": "550",
      "Protein": "35g",
      "Fat": "25g",
      "Saturated Fat": "10g",
      "Carbohydrates": "40g",
      "Fiber": "5g",
      "Sodium": "400mg",
    },
    allergenInfo: [
      "Contains gluten (cassava flour)",
      "May contain traces of nuts or soy"
    ],
    pairings: [
      "Stewed Chicken or Ponmo",
      "Palm Wine",
    ],
  ),
  Food(
    name: "Porridge with Vegetables",
    image: "assets/images/porridge.jpg",
    price: 1300,
    rating: 4.2,
    description: "Start your day with a nutritious and delicious bowl of our "
        "Nourishing Porridge with Vegetables! Our porridge is made with wholesome "
        "ingredients and cooked to perfection, creating a creamy and "
        "comforting texture that's packed with fiber and nutrients.",
    taste:
        "Our porridge has a mild and comforting flavor, with a hint of sweetness "
        "from the vegetables. The texture is creamy and smooth, making it a soothing "
        "and satisfying start to your day.",
    components: {
      "Vegetables":
          "Our porridge is loaded with a variety of fresh vegetables, carefully selected to"
              " provide a boost of vitamins and antioxidants. From the sweetness of carrots "
              "to the earthiness of spinach, our vegetables add natural flavor and"
              " texture to the porridge.",
      "Yam":
          "Our yam is boiled to a perfect consistency with a fluffy interior, "
              "making it a satisfying and filling base for your meal."
    },
    ingredients: [
      "Oats or other whole grains",
      "Vegetables (carrots, spinach, bell peppers, onions, etc.)",
      "Plant-based milk or water",
      "Spices and herbs (optional)",
    ],
    nutritionalInfo: {
      "Calories": "350",
      "Protein": "10g",
      "Fat": "10g",
      "Saturated Fat": "2g",
      "Carbohydrates": "60g",
      "Fiber": "10g",
      "Sodium": "200mg",
    },
    allergenInfo: [
      "Gluten-free",
      "Vegan-friendly",
      "May contain traces of nuts or soy",
    ],
    pairings: [
      "Fresh fruit salad",
      "Granola or nuts",
      "Honey or maple syrup (optional)",
      "Toast or whole grain bread"
    ],
  ),
  Food(
    name: "White Rice & Beans and Fried Stew",
    image: "assets/images/white rice.jpg",
    price: 1500,
    rating: 4.5,
    description:
        "Enjoy a flavorful and nutritious meal with our Rice and Beans "
        "Delight with Fried Stew! Our white rice is cooked to perfection, fluffy and light, "
        "while our beans are tender and packed with protein and fiber. Our fried stew adds a "
        "rich and savory element to the dish, with a blend of spices and vegetables "
        "that will leave you craving more.",
    components: {
      "Rice and Beans":
          "Our rice and beans are cooked together in a flavorful broth, creating a delicious "
              "and comforting base for your meal.",
      "Fried Stew":
          "Our fried stew is made with a blend of vegetables, spices, and herbs, fried to perfection "
              "to create a crispy and savory texture that complements the rice and beans perfectly.",
    },
    taste:
        "The combination of rice and beans with fried stew creates a delightful harmony "
        "of flavors and textures, with the fluffy rice and tender beans balanced by the crispy and savory stew.",
    ingredients: [
      "White rice",
      "Beans (kidney or black beans)",
      "Vegetable oil",
      "Onions, bell peppers, tomatoes",
      "Spices and herbs (thyme, rosemary, cumin)",
      "Salt and pepper",
    ],
    nutritionalInfo: {
      "Calories": "550",
      "Protein": "25g",
      "Fat": "25g",
      "Saturated Fat": "5g",
      "Carbohydrates": "60g",
      "Fiber": "10g",
      "Sodium": "400mg",
    },
    allergenInfo: ["May contain traces of nuts or soy"],
    pairings: [
      "Fried chicken or fish",
      "Grilled vegetables or salad",
      "Fried plantains or yam",
      "Garlic bread or whole grain bread",
    ],
  ),
  Food(
    name: "Yam and Fried Eggs",
    image: "assets/images/yam.jpeg",
    price: 1600,
    rating: 4.5,
    description: "Enjoy a classic Nigerian breakfast with our Yam and Fried "
        "Eggs Delight! Our yam is carefully selected and cooked to perfection, creating a "
        "deliciously tender and slightly sweet texture that pairs perfectly with "
        "our crispy and savory fried eggs.",
    components: {
      "Yam":
          "Our yam is boiled and then fried to create a crispy exterior and a fluffy interior, "
              "making it a satisfying and filling base for your meal.",
      "Fried Eggs":
          "Our eggs are fresh and expertly fried to create a crispy exterior and a runny, savory yolk."
    },
    taste:
        "The combination of yam and fried eggs creates a delightful harmony of flavors "
        "and textures, with the slightly sweet yam balanced by the savory eggs.",
    ingredients: [
      "Yam",
      "Eggs",
      "Vegetable oil",
      "Salt and pepper",
      "Onions, bell peppers, tomatoes (optional)",
    ],
    nutritionalInfo: {
      "Calories": "400",
      "Protein": "20g",
      "Fat": "20g",
      "Saturated Fat": "4g",
      "Carbohydrates": "40g",
      "Fiber": "5g",
      "Sodium": "300mg",
    },
    allergenInfo: [
      "May contain traces of nuts or soy",
    ],
    pairings: [
      "Toast or whole grain bread",
      "Fresh fruit salad",
      "Hash browns or fried plantains",
      "Grilled sausage or bacon",
    ],
  ),
  Food(
    name: "Pounded Yam with Egusi Soup",
    image: "assets/images/pounded yam.jpg",
    price: 2000,
    rating: 4.7,
    description:
        "Enjoy a traditional Nigerian meal with our Pounded Yam Delight with Egusi Soup! "
        "Our pounded yam is made from fresh yams, pounded to perfection to create a smooth and creamy texture "
        "that pairs perfectly with our flavorful egusi soup.",
    components: {
      "Pounded Yam":
          "Our pounded yam is made with fresh yams, carefully selected and pounded to create a smooth and creamy texture.",
      "Egusi Soup":
          "Our egusi soup is made with a blend of vegetables, spices, and herbs, including egusi seeds, "
              "which add a unique flavor and texture to the soup.",
    },
    taste:
        "The combination of pounded yam and egusi soup creates a delightful harmony of flavors and textures, "
        "with the smooth yam balanced by the flavorful and slightly bitter egusi soup.",
    ingredients: [
      "Fresh yams",
      "Egusi seeds",
      "Vegetables (onions, bell peppers, tomatoes)",
      "Spices and herbs (cumin, coriander, chili pepper)",
      "Palm oil or vegetable oil",
    ],
    nutritionalInfo: {
      "Calories": "500",
      "Protein": "20g",
      "Fat": "20g",
      "Saturated Fat": "5g",
      "Carbohydrates": "60g",
      "Fiber": "10g",
      "Sodium": "400mg",
    },
    allergenInfo: ["May contain traces of soy or nuts"],
    pairings: [
      "Grilled chicken or fish",
      "Fried plantains or yam",
      "Steamed vegetables or salad",
      "Garlic bread or whole grain bread"
    ],
  ),
  Food(
    name: "Spaghetti Bolognese with Sauce",
    image: "assets/images/spag.jpg",
    price: 1200,
    rating: 4.8,
    description: "Indulge in a classic Italian favorite with our Spaghetti "
        "Bolognese Delight! Our spaghetti is cooked al dente, then tossed in a rich and "
        "savory bolognese sauce made with ground beef, tomatoes, and herbs. The result is a "
        "flavorful and satisfying meal that will leave you craving more.",
    components: {
      "Spaghetti":
          "Our spaghetti is made from 100% durum wheat semolina, cooked to perfection to "
              "create a deliciously tender and firm texture.",
      "Bolognese Sauce":
          "Our bolognese sauce is made with ground beef, onions, carrots, celery, tomatoes, and "
              "herbs, slow-cooked to create a rich and savory flavor profile.",
    },
    taste:
        "The combination of spaghetti and bolognese sauce creates a delightful harmony of "
        "flavors and textures, with the tender spaghetti balanced by the rich and savory sauce.",
    ingredients: [
      "Spaghetti",
      "Ground beef",
      "Onions, carrots, celery",
      "Tomatoes",
      "Herbs (basil, oregano, thyme)",
      "Olive oil",
      "Salt and pepper",
    ],
    nutritionalInfo: {
      "Calories": "600",
      "Protein": "35g",
      "Fat": "30g",
      "Saturated Fat": "10g",
      "Carbohydrates": "60g",
      "Fiber": "5g",
      "Sodium": "500mg",
    },
    allergenInfo: [
      "Contains gluten (spaghetti)",
      "May contain traces of nuts or soy",
    ],
    pairings: [
      "Garlic bread or bruschetta",
      "Grilled chicken or meatballs",
      "Steamed vegetables or salad",
      "Tiramisu or cannoli for dessert",
    ],
  ),
  Food(
    name: "Chicken & Chips",
    image: "assets/images/c and c.jpg",
    price: 1800,
    rating: 4.2,
    description:
        "Enjoy a classic comfort food favorite with our Crispy Chicken "
        "and Chips Delight! Our juicy chicken breast is breaded and fried to perfection, "
        "served with a side of crispy and golden chips (fries) that are cooked to a crispy perfection.",
    components: {
      "Chicken":
          "Our chicken breast is marinated in a blend of spices and herbs, then breaded"
              " and fried to create a crispy exterior and a juicy interior.",
      "Chips (Fries)":
          "Our chips are made from fresh potatoes, peeled and cut to perfection, "
              "then fried to a crispy golden brown.",
    },
    taste:
        "The combination of crispy chicken and chips creates a delightful harmony of flavors and textures, "
        "with the juicy chicken balanced by the crispy and salty chips.",
    ingredients: [
      "Chicken breast",
      "Potatoes",
      "Vegetable oil",
      "Spices and herbs (salt, pepper, paprika, garlic powder)",
      "Breading mixture (flour, cornstarch, eggs)",
    ],
    nutritionalInfo: {
      "Calories": "550",
      "Protein": "30g",
      "Fat": "25g",
      "Saturated Fat": "5g",
      "Carbohydrates": "40g",
      "Fiber": "5g",
      "Sodium": "400mg",
    },
    allergenInfo: [
      "May contain traces of nuts or soy",
    ],
    pairings: [
      "Coleslaw or salad",
      "Grilled vegetables or salad",
      "Garlic bread or sandwich",
      "Soft drink or juice",
    ],
  ),
  Food(
      name: "Fruit Salad",
      image: "assets/images/salad.jpg",
      price: 1000,
      rating: 4.1,
      description:
          "Enjoy a sweet and refreshing treat with our Fresh Fruit Salad Delight! "
          "Our fruit salad is made with a variety of fresh fruits, carefully selected and "
          "mixed to create a delicious and healthy snack.",
      components: {
        "Fruits":
            "Our fruit salad includes a mix of juicy pineapple, sweet strawberries, tangy oranges, crunchy apples, and refreshing grapes.",
      },
      taste:
          "The combination of fresh fruits creates a delightful harmony of flavors and textures, "
          "with each fruit adding its unique taste and texture to the mix.",
      ingredients: [
        "Fresh fruits (pineapple, strawberries, oranges, apples, grapes)",
        "Honey (optional)",
      ],
      nutritionalInfo: {
        "Calories": "150",
        "Protein": "2g",
        "Fat": "0g",
        "Saturated Fat": "0g",
        "Carbohydrates": "35g",
        "Fiber": "5g",
        "Sodium": "10mg",
      },
      allergenInfo: [
        "May contain traces of nuts or soy",
      ],
      pairings: [
        "Yogurt or ice cream",
        "Granola or nuts",
        "Smoothie or juice",
        "Sandwich or wrap",
      ],
  ),
];
