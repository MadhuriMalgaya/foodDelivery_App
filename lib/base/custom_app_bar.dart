import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/largeText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;

  const CustomAppBar({super.key,
      required this.title,
      this.backButtonExist=true,
       this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LargeText(text: title, fontWeight: FontWeight.w500,color: Colors.white,),
      backgroundColor: appColors.mainColor,
      centerTitle: true,
      leading: backButtonExist?IconButton(
          onPressed: ()=>onBackPressed!=null?onBackPressed!():Navigator.pushReplacementNamed(context, "/initial"),
          icon: Icon(Icons.arrow_back_ios), color: Colors.white,):SizedBox(),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize =>Size(500, Dimensions.height50);
}
