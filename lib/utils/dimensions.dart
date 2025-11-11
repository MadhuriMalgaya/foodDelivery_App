import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dimensions {

  //screenheight: 820.58
  static late double screenHeight;
  static late double screenWidth;


  /// Call this once in your root widget (after context is available)
  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  // PageView
  static double get pageView => screenHeight / 2.57;
  static double get pageViewContainer => screenHeight / 3.83;
  static double get pageViewTextController => screenHeight / 7.02;

  // Dynamic height padding and margin
  static double get height2 => screenHeight / 410.2;
  static double get height4 => screenHeight / 205.1;
  static double get height8 => screenHeight / 102.5;
  static double get divider => screenHeight / 820.5;
  static double get height10 => screenHeight / 82.0;
  static double get height12 => screenHeight / 68.3;
  static double get height20 => screenHeight / 41.0;
  static double get height25 => screenHeight / 32.8;
  static double get height30 => screenHeight / 27.3;
  static double get height40 => screenHeight / 20.5;
  static double get height45 => screenHeight / 18.2;
  static double get height50 => screenHeight / 16.4;
  static double get height70 => screenHeight / 11.7;
  static double get height120 => screenHeight / 6.8;
  static double get height150 => screenHeight / 5.4;
  static double get height180 => screenHeight / 4.5;
  static double get height100 => screenHeight / 8.2;
  static double get align=> screenHeight / 760.2;
  static double get top10=>screenHeight/82.0;
  static double get top195 => screenHeight / 4.2;
  static double get top15=> screenHeight/54.7;
  static double get bottom15=> screenHeight/54.7;
  static double get top45=> screenHeight/18.2;
  static double get top20 => screenHeight / 41.0;
  static double get popularFoodImage => screenHeight /2.7;

  // Dynamic width padding and margin
  static double get width5 => screenHeight/ 164.1;
  static double get width8 => screenHeight / 102.5;
  static double get width10 => screenHeight / 82.0;
  static double get width15 => screenHeight / 54.7;
  static double get width20 => screenHeight/ 41.0;
  static double get width25 => screenHeight / 32.8;
  static double get width30 => screenHeight / 27.3;
  static double get width60 => screenHeight / 13.6;
  static double get width380 => screenHeight / 1.8;

  // Fonts and radius
  static double get font13 => screenHeight / 63.1;
  static double get font16 => screenHeight / 51.2;
  static double get font15 => screenHeight / 54.7;
  static double get font18 => screenHeight / 45.5;
  static double get font20 => screenHeight / 41.0;
  static double get font25 => screenHeight / 32.8;
  static double get radius15 => screenHeight / 54.7;
  static double get radius20 => screenHeight / 41.0;
  static double get radius30 => screenHeight / 27.3;


  // Icon size
  static double get iconSize24 => screenHeight / 34.1;
  static double get icon18 => screenHeight / 45.5;
  static double get icon20 => screenHeight / 41.0;
  static double get icon25 => screenHeight / 32.8;

  // list  view size
  static double get height210 => screenHeight / 3.9;
  static double get listViewImage => screenHeight /7.2;
  static double get listViewTextContSize => screenHeight/9.1;
  static double get height200 => screenHeight/4.1;
  static double get height80 => screenHeight/10.2;
  static double get height110 => screenHeight/7.4;

  // GetBottomFoodOrder
  static double get FoodImgSize => screenHeight /3.2;
}