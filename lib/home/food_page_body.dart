import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/home/State_famous_foods/state_food_images_and_names.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import 'State_famous_foods/state_food.dart';

class FoodPageBody extends StatefulWidget{
  @override

  State<StatefulWidget> createState() => _FoodPageBodyState();
}
class _FoodPageBodyState extends State<FoodPageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue =0.0;
  double _scaleFcator =0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener((){
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded? Container(
            margin: EdgeInsets.only(top: Dimensions.top15),
            height: Dimensions.pageView,
            // color: Colors.red,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return _buildListItem(index, popularProducts.popularProductList[index]);
                }),
          ):
          CircularProgressIndicator(
            color: appColors.mainColor,
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return  DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1:popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
                activeColor: appColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
            ),);
        }),

        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LargeText(text: "Recommended",fontWeight: FontWeight.w500),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: LargeText(text: ".", color: Colors.black26,fontWeight: FontWeight.w500),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        SizedBox(height: Dimensions.height20,),
        //list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
          return recommendedProducts.isLoaded? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context, index){
                var product = recommendedProducts.recommendedProductList[index];
                return
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedOrderPage(product.id!,"home"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height20),
                      child: Row(
                        children: [
                          //image section
                          Container(
                              width: Dimensions.listViewImage,
                              height: Dimensions.listViewImage,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${AppConstants.BASE_URL}/uploads/${recommendedProducts.recommendedProductList[index].img}"
                                    ),
                                    fit: BoxFit.cover
                                ),
                              )
                          ),
                          //text section
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(Dimensions.radius20),
                                      bottomRight: Radius.circular(Dimensions.radius20)),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding:  EdgeInsets.only(left: Dimensions.width10,  right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LargeText(text: "${recommendedProducts.recommendedProductList[index].name}",fontWeight: FontWeight.w500),
                                    SizedBox(height: Dimensions.height10,),
                                    SmallText(text: "With Indian characteristics"),
                                    SizedBox(height: Dimensions.height10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(text: "Normal", icon: Icons.circle, iconColor: appColors.iconColor1),
                                        IconAndTextWidget(text: "1.7km", icon: Icons.location_on, iconColor: appColors.iconColor3),
                                        IconAndTextWidget(text: "32min", icon: Icons.watch_later_outlined, iconColor: appColors.iconColor2)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          //
                        ],
                      ),
                    ),
                  );
              }):
              CircularProgressIndicator(
                color: appColors.mainColor,
              );
        }),
        SizedBox(height: Dimensions.height30,),
        /*Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LargeText(text: "States Famous Foods",fontWeight: FontWeight.w500),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: LargeText(text: ".", color: Colors.black26,fontWeight: FontWeight.w500),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        SizedBox(height: Dimensions.height10,),
        Container(
          alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StateFood(stateName: stateFoods[0].stateName, foods: stateFoods[0].foods),
                SizedBox(height: Dimensions.height20,),
              ],
            )
        )*/
      ],


    );
  }
  Widget _buildListItem(int position, Products popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(position == _currentPageValue.floor()){
      var currentScale = 1-(_currentPageValue-position)*(1-_scaleFcator);
      var currentTrans = _height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }else if(position == _currentPageValue.floor()+1){
      var currentScale= _scaleFcator+ (_currentPageValue-position+1) * (1-_scaleFcator);
      var currentTrans = _height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1,currentScale,1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }else if(position == _currentPageValue.floor()-1){
      var currentScale= 1- (_currentPageValue-position) * (1-_scaleFcator);
      var currentTrans = _height*(1-currentScale)/2;
      matrix = Matrix4.diagonal3Values(1,currentScale,1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);

    }else{
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1,currentScale,1)..setTranslationRaw(0, _height*(1-_scaleFcator)/2, 1);

    }
    return Transform(
      transform: matrix,
      child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getRestaurantNames(popularProduct.id!));
              },
              child: Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: appColors.iconColor1,
                    image:  DecorationImage(
                        image: NetworkImage(
                            "${AppConstants.BASE_URL}/uploads/${popularProduct.img}"),
                    fit: BoxFit.cover,
                    ),

                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.bottom15),
                height: Dimensions.pageViewTextController,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                    color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)
                  ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0)
                    )]
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.top10, left: Dimensions.width10,right: Dimensions.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(text:"${popularProduct.name}",fontWeight: FontWeight.w500,),
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
                      )
                    ],
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}





