import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter=0;

    Widget timeWidget(int index){
      var outputData =DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseData= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseData.toString());
        var outputFormat =DateFormat("MM/dd/yyyy hh:mm a");
        outputData = outputFormat.format(inputDate);

      }
      return LargeText(text: outputData, fontWeight: FontWeight.w400, size: Dimensions.font18,);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height80,
            padding: EdgeInsets.only(top: Dimensions.height40),
            decoration: BoxDecoration(
              color: appColors.mainColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10),
                  child: LargeText(text: "Cart History", fontWeight: FontWeight.w500, color: Colors.white, size: Dimensions.font18,),
                ),
                Container(
                  height: Dimensions.height30,
                  width: Dimensions.height30,
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                    child: Icon(Icons.shopping_cart,
                      color: appColors.mainColor,))
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().isNotEmpty ?
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.height20,
                      right: Dimensions.height20,
                      bottom: Dimensions.height8
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i=0; i<itemsPerOrder.length; i++)
                          Container(
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.height80,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(itemsPerOrder[i], (index) {
                                            if (listCounter < getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return Container(
                                              height: Dimensions.height80,
                                              width: Dimensions.height80,
                                              margin: EdgeInsets.only(right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.width8),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "${AppConstants.BASE_URL}/uploads/${getCartHistoryList[listCounter - 1].img!}",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                child: Image.network(
                                                  "${AppConstants.BASE_URL}/uploads/${getCartHistoryList[listCounter - 1].img!}",
                                                  width: Dimensions.height80,
                                                  height: Dimensions.height80,
                                                  fit: BoxFit.cover,
                                                  // Show progress while loading
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
                                                  // Fallback if image fails to load
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    return Container(
                                                      height: Dimensions.height80,
                                                      width: Dimensions.height80,
                                                      color: Colors.grey.shade200,
                                                      child: Icon(Icons.image_not_supported, color: Colors.grey, size: Dimensions.height40),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width5,),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(
                                            text: "Total",
                                            size: Dimensions.font13,
                                            color: Colors.black45,
                                          ),
                                          LargeText(
                                            text: "${itemsPerOrder[i]} Items",
                                            fontWeight: FontWeight.w400,
                                            color: appColors.titleColor,
                                            size: Dimensions.font15,
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder={};
                                              for(int j=0; j<getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].time==orderTime[i]){
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!, ()=>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());

                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical: Dimensions.width5,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.width5),
                                                border: Border.all(width: 1, color: appColors.mainColor),
                                              ),
                                              child: SmallText(
                                                text: "one more",
                                                color: appColors.mainColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),

                          )
                      ],
                    ),)
              ),
            ):
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: Center(
                    child: const NoDataPage(text: "You did not but anything so far!",
                      imgPath: "assets/images/emptyBag.png",),
                  ),
                );
          })
        ],
      ),
    );
  }
}
