import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/AppIcon.dart';
import 'package:food_delivery/widgets/exandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';
import '../widgets/small_text.dart';

class GetBottomFoodOrderPage extends StatefulWidget{
  final int foodVarietyId;
  const GetBottomFoodOrderPage({super.key, required this.foodVarietyId});


  @override
  State<StatefulWidget> createState() => _GetBottomFoodOrderPageState();
}

class _GetBottomFoodOrderPageState extends State<GetBottomFoodOrderPage>{
  late Varieties selectedVariety;

  @override
  void initState() {
    super.initState();

    final productList = Get.find<PopularProductController>().popularProductList;

    selectedVariety = productList
        .expand((product) => product.varieties ?? [])
        .firstWhere(
          (v) => v.id == widget.foodVarietyId,
      orElse: () => null,
    );
  }


  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().initProduct(selectedVariety, Get.find<CartController>());


    return Container(
      width: double.infinity,
      color: Color(0xFFE5F3FD),
      child: Stack(
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 550,
              margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.top15),
              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.top10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.width10),

              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.width10),
                      child: Image.network(
                        "${AppConstants.BASE_URL}/uploads/${selectedVariety.img}",
                        height: Dimensions.height200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        // Shows fallback if image fails to load
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Container(
                            height: Dimensions.height200,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.image_not_supported, color: Colors.grey, size: Dimensions.height40),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Dimensions.width20,
                          width: Dimensions.width20,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(Dimensions.width5),
                          ),
                          child: Center(
                            child: Container(
                              width: Dimensions.width10,
                              height: Dimensions.width10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<PopularProductController>(builder: (controller){
                          return Stack(
                            children: [
                              AppIcon(
                                iconData: Icons.shopping_cart_outlined,
                              ),
                              // Only show badge if totalItems >= 1
                              Get.find<PopularProductController>().totalItems >= 1
                                  ? Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: appColors.mainColor, // badge background
                                  ),
                                  child: Center(
                                    child: LargeText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      color: Colors.white,
                                      size: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                                  : Container(),
                            ],
                          );

                        })
                      ],
                    ),
                    SizedBox(height: Dimensions.height10,),
                    LargeText(text: selectedVariety.name ?? "",fontWeight: FontWeight.w500 ),
                    SizedBox(height: Dimensions.height10,),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index)=>
                              Icon(Icons.star, color: appColors.mainColor, size: 17,)),
                        ),
                        SizedBox(width: 9,),
                        SmallText(text: "4.5", color: appColors.textColour,),
                        SizedBox(width: 9,),
                        SmallText(text: "1255", color: appColors.textColour,),
                        SizedBox(width: 9,),
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
                    SizedBox(height: Dimensions.height20,),
                    LargeText(text: "Introduce",fontWeight: FontWeight.w400 ),
                    SizedBox(height: Dimensions.height20,),
                    SingleChildScrollView(
                      child: ExpandableTextWidget(text: selectedVariety.description?? "No description", ),
                    ),
                    SizedBox(height: Dimensions.height20 ,)
                  ],
                ),
              ),
            ),
          ],
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GetBuilder<PopularProductController>(builder: (popularProduct){
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
                                  popularProduct.setQuantity(false);
                                },
                                child: Icon(Icons.remove, color: appColors.mainColor, size: Dimensions.height20 )),
                            LargeText(text: popularProduct.inCartItems.toString(), fontWeight: FontWeight.w500, size: 25,),
                            GestureDetector(
                                onTap: (){
                                  popularProduct.setQuantity(true);
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
                                  popularProduct.addItems(selectedVariety);
                                },
                                child: LargeText(text: "Add to Cart", fontWeight: FontWeight.w500, color: Colors.white, size: Dimensions.width20,)),
                            SizedBox(width: Dimensions.width5,),
                            Icon(Icons.currency_rupee, size: Dimensions.width20, color: Colors.white,),
                            LargeText(text: "${selectedVariety.price}", fontWeight: FontWeight.w500, size: Dimensions.width20, color: Colors.white,),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            })
          )
      ]
      ),

    );
  }

}