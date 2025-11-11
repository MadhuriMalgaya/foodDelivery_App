import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOption({super.key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
              activeColor: Theme.of(context).primaryColor,
              value: value,
              groupValue: orderController.orderType,
              onChanged: (String? value)=>orderController.setDelivery(value!)),
          SizedBox(width: Dimensions.width5,),
          Text(title, ),
          SizedBox(width: Dimensions.width5,),
          Text(
            '(${(value=="take away" || isFree)?'Free':'\₹${amount/10}'})',
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      );
    });
  }
}
