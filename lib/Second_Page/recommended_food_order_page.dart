import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/home/main_food_Page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/icons.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../utils/colors.dart';
import '../widgets/exandable_text_widget.dart';
import '../widgets/icon_and_text_widget.dart';
import '../widgets/largeText.dart';
import '../widgets/small_text.dart';

class RecommendedFoodOrderPage extends StatelessWidget {
  final int recommendedId;
  final String page;
  const RecommendedFoodOrderPage({super.key, required this.recommendedId, required this.page});

  @override
  Widget build(BuildContext context) {
    final recommendedController = Get.find<RecommendedProductController>();

    // Find product safely
    final index = recommendedController.recommendedProductList
        .indexWhere((item) => item.id == recommendedId);

    if (index < 0) {
      // Product not found → history product
      Future.delayed(Duration.zero, () {
        Get.back(); // Close page
        Get.snackbar(
          "History product",
          "This recommended product is no longer available",
          backgroundColor: appColors.mainColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      });

      return Container(); // Empty widget to avoid crash
    }

    // Product exists
    final product = recommendedController.recommendedProductList[index];

    Get.find<RecommendedProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImage,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "${AppConstants.BASE_URL}/uploads/${product.img}"),
                  fit: BoxFit.cover)
                ),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(page=="cartPage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: IconsData(iconData: Icons.clear ),
                  ),
                 GetBuilder<RecommendedProductController>(builder: (controller){
                   return GestureDetector(
                     onTap: (){
                         if(controller.totalItems >= 1) {
                         Get.toNamed(RouteHelper.getCartPage());
                       }
                     },
                     child: Stack(
                       children: [
                         IconsData(
                           iconData: Icons.shopping_cart_outlined,),
                         Get.find<RecommendedProductController>().totalItems >= 1 ?
                              Positioned(
                               right: 0,
                               top: 0,
                               child: Container(
                                 padding: EdgeInsets.all(Dimensions.height4),
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.redAccent, // badge background
                                 ),
                                 child: Center(
                                   child: LargeText(
                                     text: Get.find<RecommendedProductController>().totalItems.toString(),
                                     color: Colors.white,
                                     size: Dimensions.font13,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                               ),
                         )
                             : Container(),
                       ],
                     ),
                   );
                 })
                ],
              )),
                Positioned(
                   left: 0,
                    right: 0,
                    bottom: 0,
                    top: Dimensions.popularFoodImage-15,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                            topLeft: Radius.circular(Dimensions.radius20)
                          ),
                          color: Colors.white
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: Dimensions.top10, left: Dimensions.width10,right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LargeText(text:product.name!,fontWeight: FontWeight.w500,),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                children: [
                                  Wrap(
                                    children: List.generate(5, (index)=>
                                        Icon(Icons.star, color: appColors.mainColor, size: Dimensions.width15+2,)),
                                  ),
                                  SizedBox(width: Dimensions.width8,),
                                  SmallText(text: "4.5", color: appColors.textColour,),
                                  SizedBox(width: Dimensions.width8,),
                                  SmallText(text: "1255", color: appColors.textColour,),
                                  SizedBox(width: Dimensions.width8,),
                                  SmallText(text: "comments", color: appColors.textColour,)
                          ],
                        ),
                            SizedBox(height: Dimensions.height20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(text: "Normal", icon: Icons.circle, iconColor: appColors.iconColor1),
                                IconAndTextWidget(text: "1.7km", icon: Icons.location_on, iconColor: appColors.iconColor3),
                                IconAndTextWidget(text: "32min", icon: Icons.watch_later_outlined,  iconColor: appColors.iconColor2)
                              ],
                            ),
                            SizedBox(height: Dimensions.height20),
                            LargeText(text: "Introduce",fontWeight: FontWeight.w400 ),
                            SizedBox(height: Dimensions.height10,),
                            SingleChildScrollView(
                              child: ExpandableTextWidget(text: product.description!),
                            ),
                            SizedBox(height: Dimensions.height20 ,)
                      ],
                      
                                        ),
                                      ),
                                    ),
                    ))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return Container(
              height: Dimensions.height100,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: Dimensions.height50,
                      margin:  EdgeInsets.symmetric(horizontal: Dimensions.width10,),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.width10),
                          color:  const Color(0xffcac2de),
                          border: Border.all(color: appColors.mainColor, width: Dimensions.height2)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                recommendedProduct.setQuantity(false);
                              },
                              child: Icon(Icons.remove, color: appColors.mainColor, size: Dimensions.height20 )),
                          LargeText(text: recommendedProduct.inCartItems.toString(), fontWeight: FontWeight.w500, size: 25,),
                          GestureDetector(
                              onTap: (){
                                recommendedProduct.setQuantity(true);
                              },
                              child: Icon(Icons.add, color: appColors.mainColor, size: Dimensions.height20,))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width5,),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: Dimensions.height50,
                      margin:  EdgeInsets.symmetric(vertical: Dimensions.width15,horizontal: Dimensions.width10),
                      decoration: BoxDecoration(
                          color: appColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.width10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){
                                recommendedProduct.addItems(product);
                              },
                              child: LargeText(text: "Add to Cart", fontWeight: FontWeight.w500, color: Colors.white, size: Dimensions.width20,)),
                          SizedBox(width: Dimensions.width5,),
                          Icon(Icons.currency_rupee, size: Dimensions.width20, color: Colors.white,),
                          LargeText(text: "${product.price}", fontWeight: FontWeight.w500, size: Dimensions.width20, color: Colors.white,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
