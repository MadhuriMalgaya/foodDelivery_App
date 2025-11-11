import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';

class IconsData extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double size;
  final double iconsize;
  final Color backgroundColor;

  const IconsData({super.key,
    required this.iconData,
    this.iconColor = const Color(0xfff8f4f4),
    this.size = 50,
    this.iconsize =20,
    this.backgroundColor = const Color(0xFF100F0F),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child: Icon(iconData,
      color: iconColor,
      size: iconsize,),
    );
  }
}
