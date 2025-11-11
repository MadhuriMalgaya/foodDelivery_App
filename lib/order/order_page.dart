import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/order/view_order.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {

  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn= Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController= TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Orders"),
      body: _isLoggedIn ?
      Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: Dimensions.height2,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                dividerHeight: 0,
                controller: _tabController,
                tabs: const [
                  Tab(text: "current",),
                  Tab(text: "history",)
                ]),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const[
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false)
                ]),
          )
        ],
      )
          : Center(
           child:  Text("Please Register or login first",
            style: TextStyle(
              fontSize: Dimensions.font18,
              color: Theme.of(context).disabledColor,
            ),),
      )
    );
  }
}
