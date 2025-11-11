import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionButton({super.key,
   required this.index,
  required this.iconData,
  required this.title,
  required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1
                )
              ]
          ),
          child: ListTile(
            leading: Icon(
              iconData,
              size: Dimensions.height40,
              color: _selected?Theme.of(context).primaryColor: Theme.of(context).disabledColor,
            ),
            title: Text(title,style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(subTitle,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).disabledColor),),
            trailing: _selected?Icon(Icons.check_circle, color: Theme.of(context).primaryColor,):null,
          ),
        ),
      );
    });
  }
}
