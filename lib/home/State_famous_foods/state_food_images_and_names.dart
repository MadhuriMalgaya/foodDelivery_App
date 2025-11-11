import 'package:flutter/cupertino.dart';

class FoodItem {
  final String foodName;
  final String imagePath;

  FoodItem({required this.foodName, required this.imagePath});
}

class StateFoodModel {
  final String stateName;
  final List<FoodItem> foods;

  StateFoodModel({required this.stateName, required this.foods});
}

// Example data
List<StateFoodModel> stateFoods = [
  StateFoodModel(
    stateName: "Punjab",
    foods: [
      FoodItem(foodName: "Amritsari Kulcha", imagePath: "assets/images/states_food/punjab_food/amritsari_kulcha.png"),
      FoodItem(foodName: "Dal Makhni", imagePath: "assets/images/states_food/punjab_food/dal_makhni.jpg"),
      FoodItem(foodName: "Lassi", imagePath: "assets/images/states_food/punjab_food/lassi.jpg"),
      FoodItem(foodName: "Makke ki Roti And Sarso ki saag", imagePath: "assets/images/states_food/punjab_food/makke_di_roti_and_sarso_saag.png")
    ],
  ),
  StateFoodModel(
    stateName: "Rajasthan",
    foods: [
      FoodItem(foodName: "Dal Baati Churma", imagePath: "assets/images/Dal_Bati.jpg"),
      FoodItem(foodName: "Ghevar", imagePath: "assets/images/veg_thali.png"),
    ],
  ),
];

