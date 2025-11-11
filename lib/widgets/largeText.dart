import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class LargeText extends StatelessWidget{
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;

  LargeText({
      this.color = const Color(0xFF332D2b),
      required this.text,
      required this.fontWeight,
      this.size = 0,
    this.overflow = TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
        overflow: overflow,
        maxLines: 1,
        style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontFamily: "Roboto",
            fontSize: size==0?Dimensions.font20: size
        ),
    );
  }

}