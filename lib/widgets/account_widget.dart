import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/icons.dart';
import 'package:food_delivery/widgets/largeText.dart';

class AccountWidget extends StatelessWidget {
  IconsData iconsData;
  LargeText largeText;

  AccountWidget({super.key, required this.iconsData, required this.largeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.width10, bottom: Dimensions.width10),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),

          )
        ]
      ),
      child: Row(
        children: [
          iconsData,
          SizedBox(width: Dimensions.width20,),
          largeText
        ],
      ),
    );
  }
}
