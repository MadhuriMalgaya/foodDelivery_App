import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/dimensions.dart';

class RestaurantsDetails extends StatelessWidget{
  final int productId;
  RestaurantsDetails({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    var product = Get.find<PopularProductController>().popularProductList.firstWhere((item)=> item.id== productId);
    print(productId);
    print(product);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.top45),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: (){
                   Get.toNamed(RouteHelper.getInitial());
                  },
                  child: Container(
                    height: Dimensions.top45,
                    width: Dimensions.top45,
                    decoration: BoxDecoration(
                        color: appColors.mainColor,
                      shape:  BoxShape.circle
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                ),
                  Container(
                    height: Dimensions.top45,
                    width: Dimensions.top45,
                    decoration: BoxDecoration(
                      shape:  BoxShape.circle,
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
          ),
          SizedBox(height: Dimensions.height10,),
          Container(
            padding: EdgeInsets.only(left: Dimensions.width30),
            child: LargeText(text: "ALL RESTAURANTS", size: Dimensions.font18, color: appColors.textColour,fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: product.restaurants?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                var restaurants = product.restaurants![index];
                return _allRestaurants(restaurants);
                }),
          )
        ],
      ),
    );
  }

  Widget _allRestaurants(Restaurants restaurants) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteHelper.getFoodVarieties(restaurants.id!));
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.width25, right: Dimensions.width25, bottom: Dimensions.width30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 7)
              ),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-7, 0)
              ),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(7, 0)
              )],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius15),
                topRight: Radius.circular(Dimensions.radius15),
              ),
              child: Stack(
                children: [
                  Container(
                  height: Dimensions.pageViewContainer,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "${AppConstants.BASE_URL}/uploads/${restaurants.img ?? Icon(Icons.insert_page_break_outlined)}"
                        ),
                    fit: BoxFit.cover)
                  ),
                ),
                  Positioned(
                     top: Dimensions.top195,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.height45)),
                          color: Colors.white,
                        ),
                        width: Dimensions.height180,
                        height: Dimensions.height20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.width10),
                              child: Icon(Icons.watch_later_outlined, size: Dimensions.font15,color: Colors.grey.shade700,),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.width10),
                              child: SmallText(text: "25-30 mins", color: Colors.grey.shade700,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10),
                              child: SmallText(text: "2.8km ", color: Colors.grey.shade700,),
                            )
                          ],
                        ),

                      ))
               ]
              ),
            ),

            // 🔹 Bottom details (white container automatically attached)
            Container(
              padding: EdgeInsets.all(Dimensions.height12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius20),
                  bottomRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(restaurants.name ?? "Unknown Restaurant", style: TextStyle(color: Colors.black, fontFamily: "Roboto",fontWeight: FontWeight.w700, fontSize: Dimensions.font20),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width8, vertical: Dimensions.width5),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(Dimensions.width8),
                        ),
                        child: Row(
                          children: [
                            Text("${restaurants.rating?? 0.0}", style: TextStyle(color: Colors.white)),
                            Icon(Icons.star, color: Colors.white, size: Dimensions.icon18),

                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_offer, color: Colors.blue, size: Dimensions.font15,),
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.width10),
                        child: SmallText(text: "Flat 50% OFF", size: Dimensions.font13, color: Colors.grey.shade700,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
}

