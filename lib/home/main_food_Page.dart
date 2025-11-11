import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/home/food_page_body.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedproductList();
  }


  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadResources,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(), // allows pull-to-refresh even if content is short
          children: [
            topHeading(),     // your heading widget
            const SizedBox(height: 8),
            FoodPageBody(),   // MUST NOT contain its own scrollable (see note below)
          ],
        ),
      ),
    );
  }

}
class topHeading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.top45),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              LargeText(
                text: "India",
                color: appColors.mainColor,
                  fontWeight: FontWeight.w500
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: SmallText(
                      text: "Kharar",
                      color: appColors.mainBlackColor,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ],
          ),
          Container(
            height: Dimensions.top45,
            width: Dimensions.top45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: appColors.mainColor,
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: Dimensions.iconSize24,
            ),
          )
        ],
      ),
    );
  }
}
