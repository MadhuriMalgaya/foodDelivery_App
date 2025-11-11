import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';

class SmallText extends StatelessWidget{

  final String text;
  Color? color;
  double size;
  double height;


  SmallText({
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size= 10,
    this.height=1.2
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
          fontFamily: "Roboto",
          color: color,
          height: height
      ),
    );
  }
}