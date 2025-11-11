import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget{

  final IconData iconData;
  final Color iconColor;
  final double iconsize;
  final Color backgroundColor;

  AppIcon({
    required this.iconData,
    this.iconColor = const Color(0xff9360f6),
    this.iconsize = 40,
    this.backgroundColor = const Color(0xFF756D54),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height40,
      width: Dimensions.height40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.width5)
      ),
      child: Icon(
          iconData,
          color: iconColor,
      ),
    );
  }

}