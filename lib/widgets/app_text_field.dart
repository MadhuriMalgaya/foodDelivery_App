import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  bool isObscure;
  bool maxLines;

   AppTextField({super.key,
  required this.textEditingController,
  required this.iconData,
  required this.hintText,
  this.isObscure= false,
   this.maxLines=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.radius15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        maxLines: maxLines?3:1,
        obscureText: isObscure?true:false,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(iconData, color: appColors.mainColor,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15)
            )
        ),
      ),
    );
  }
}
