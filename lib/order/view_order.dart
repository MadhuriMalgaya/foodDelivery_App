import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (!orderController.isLoading) {
          // Always initialize
          List<OrderModel> orderList = isCurrent
              ? orderController.currentOrderList.reversed.toList()
              : orderController.historyOrderList.reversed.toList();

          if (orderList.isEmpty) {
            return Center(
              child: Text(
                isCurrent
                    ? "You don’t have any current orders.\nPlease order something 🙂"
                    : "No past orders found.\nStart by placing your first order!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.font18,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            );
          }

          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width8, vertical: Dimensions.height4),
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => null,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("#order ID",
                                    style: TextStyle(fontSize: Dimensions.font16)),
                                SizedBox(width: Dimensions.height30),
                                Text(orderList[index].id.toString(),
                                    style: TextStyle(fontSize: Dimensions.font16)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: appColors.mainColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 / 5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width8,
                                      vertical: Dimensions.height2),
                                  child: Text(
                                    '${orderList[index].orderStatus}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.font13),
                                  ),
                                ),
                                SizedBox(height: Dimensions.width5),
                                InkWell(
                                  onTap: () => null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width8,
                                        vertical: Dimensions.height4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20 / 5),
                                      border: Border.all(
                                          width: 0.8,
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/tracking.PNG",
                                          height: Dimensions.height20,
                                          width: Dimensions.height20,
                                          color: appColors.mainColor,
                                        ),
                                        SizedBox(width: Dimensions.height4),
                                        Text("Track order",
                                            style: TextStyle(
                                                fontSize: Dimensions.font13)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.height12),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
