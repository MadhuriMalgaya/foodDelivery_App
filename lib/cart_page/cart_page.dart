import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/order/delivery_option.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:food_delivery/order/payment_option_button.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../third_page/GetBottomFoodOrderPage.dart';

class CartPage extends StatelessWidget{
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
              top: Dimensions.width60,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(
                   height: Dimensions.height40,
                   width:  Dimensions.height40,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: appColors.mainColor
                   ),
                   child: Icon(Icons.arrow_back_ios_new,
                   color: Colors.white,),
                 ),
                  SizedBox(width: Dimensions.width60,),
                  Container(
                    height: Dimensions.height40,
                    width:  Dimensions.height40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appColors.mainColor
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: Icon(Icons.home,
                        color: Colors.white,),
                    ),
                  ),
                  GetBuilder<CartController>(builder: (controller){
                    return Stack(
                      children: [
                        Container(
                        height: Dimensions.height40,
                        width:  Dimensions.height40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appColors.mainColor
                        ),
                        child: Icon(Icons.shopping_cart,
                          color: Colors.white,),
                       ),
                          controller.totalItems >= 1 ?
                              Positioned(
                                right: 0,
                                  top: 0,
                                  child: Container(
                                    height: Dimensions.width20,
                                    width: Dimensions.width20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.redAccent, // badge background
                                    ),
                                    child: Center(
                                      child: LargeText(
                                        text: Get.find<PopularProductController>().totalItems.toString(),
                                        color: Colors.white,
                                        size: Dimensions.font13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              )
                              : Container(),
                     ]
                    );
                  })
                ],
              )),
         GetBuilder<CartController>(builder: (cartController){
           return cartController.getItems.isNotEmpty?
           Positioned(
               top: Dimensions.height100,
               left: Dimensions.width20,
               right: Dimensions.width20,
               bottom: 0,
               child: Container(
                 margin: EdgeInsets.only(top: Dimensions.width20),
                 child: MediaQuery.removePadding(
                   context: context,
                   removeTop: true,
                   child: GetBuilder<CartController>(builder: (cartController){
                     var _cartList = cartController.getItems;
                     return ListView.builder(
                         itemCount: _cartList.length,
                         itemBuilder: (context, index){
                           return Container(
                             height: Dimensions.height100,
                             width: double.maxFinite,
                             margin: EdgeInsets.only(bottom: Dimensions.width15),
                             child: Row(
                               children: [
                                 GestureDetector(
                                     onTap: () {
                                       final cartItem = _cartList[index];

//                                    Case 1: Varieties
                                       if (cartItem.product != null && cartItem.product!.id != null) {
                                         final varietyId = cartItem.product!.id!;
                                         final productController = Get.find<PopularProductController>().popularProductList.expand((p) => p.varieties ?? []).any((v) => v.id == varietyId);

                                         if (productController) {
                                           Get.bottomSheet(
                                             Container(
                                               height: MediaQuery.of(context).size.height * 0.85,
                                               color: Colors.white,
                                               child: GetBottomFoodOrderPage(foodVarietyId: varietyId),
                                             ),
                                             isScrollControlled: true,
                                             backgroundColor: Colors.transparent,
                                           );
                                         } else {
                                           Get.snackbar("History product", "This product is no longer available",
                                             backgroundColor: appColors.mainColor,
                                             colorText: Colors.white,
                                             snackPosition: SnackPosition.BOTTOM,
                                           );
                                         }

                                      // Case 2: Recommended
                                       } else if (cartItem.recommendedProduct != null && cartItem.recommendedProduct!.id != null) {
                                         final recommendedId = cartItem.recommendedProduct!.id!;
                                         final recommendedController = Get.find<RecommendedProductController>().recommendedProductList
                                             .any((item) => item.id == recommendedId);

                                         if (recommendedController) {
                                           Get.toNamed(RouteHelper.getRecommendedOrderPage(recommendedId, "cartPage"));
                                         } else {
                                           Get.snackbar("History product", "This recommended product is no longer available",
                                             backgroundColor: appColors.mainColor,
                                             colorText: Colors.white,
                                             snackPosition: SnackPosition.BOTTOM,
                                           );
                                         }

                                     // Case 3: History
                                       } else {
                                         Get.snackbar("History product", "Product review is not available for history products",
                                           backgroundColor: appColors.mainColor,
                                           colorText: Colors.white,
                                           snackPosition: SnackPosition.BOTTOM,
                                         );
                                       }},

                                     child: ClipRRect(
                                     borderRadius: BorderRadius.circular(Dimensions.radius20),
                                     child: Image.network(
                                       "${AppConstants.BASE_URL}/uploads/${cartController.getItems[index].img ?? 'default.png'}",
                                       width: Dimensions.height100,
                                       height: Dimensions.height100,
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
                                           height: Dimensions.height100,
                                           width: Dimensions.height100,
                                           color: Colors.grey.shade200,
                                           child: Icon(Icons.image_not_supported, color: Colors.grey, size: Dimensions.height40),
                                         );
                                       },
                                     ),
                                   )

                                 ),
                                 SizedBox(width: Dimensions.width10,),
                                 Expanded(child: Container(
                                   height: Dimensions.height100,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       LargeText(text: cartController.getItems[index].name ?? "Unknown Food", fontWeight: FontWeight.w600, color: Colors.black54,),
                                       SmallText(text: "Tasty Food", size: Dimensions.font13,),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           LargeText(text: "\₹ ${cartController.getItems[index].price ?? 0}", fontWeight: FontWeight.w600, color: Colors.redAccent,),
                                           Container(

                                             padding: EdgeInsets.only(top: Dimensions.height2, bottom: Dimensions.height2, right: Dimensions.width10, left: Dimensions.width10),
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(Dimensions.width10),
                                               color:  Colors.white,

                                             ),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 GestureDetector(
                                                   onTap: () {
                                                     final product = _cartList[index].product;
                                                     final recommended = _cartList[index].recommendedProduct;

                                                     if (product != null) {
                                                       cartController.addItem(product, -1);
                                                     } else if (recommended != null) {
                                                       cartController.addRecommendedItem(recommended, -1);
                                                     }
                                                   },
                                                   child: Icon(Icons.remove, color: appColors.mainColor, size: Dimensions.height20),
                                                 ),
                                                 SizedBox(width: Dimensions.width10),
                                                 LargeText(
                                                   text: (_cartList[index].quantity ?? 0).toString(),
                                                   fontWeight: FontWeight.w600,
                                                   size: Dimensions.font18,
                                                 ),
                                                 SizedBox(width: Dimensions.width10),
                                                 GestureDetector(
                                                   onTap: () {
                                                     final product = _cartList[index].product;
                                                     final recommended = _cartList[index].recommendedProduct;

                                                     if (product != null) {
                                                       cartController.addItem(product, 1);
                                                     } else if (recommended != null) {
                                                       cartController.addRecommendedItem(recommended, 1);
                                                     }
                                                   },
                                                   child: Icon(Icons.add, color: appColors.mainColor, size: Dimensions.height20),
                                                 ),
                                               ],
                                             )

                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ))
                               ],
                             ),
                           );


                         });
                   }),
                 ),
               )): NoDataPage(text: "Go Find the food you like!");
         })
        ],
      ),
     bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
       _noteController.text = orderController.foodNote;
       return GetBuilder<CartController>(builder: (controller){
         return Container(
             height: Dimensions.height150,
             decoration: BoxDecoration(
               color: appColors.buttonBackgroundColor,
             ),
             child: controller.getItems.length >0?
             Column(
               children: [
                 InkWell(
                   onTap: ()=> showModalBottomSheet(
                       backgroundColor: Colors.transparent,
                       context: context,
                       builder: (_){
                         return Column(
                           children: [
                             Expanded(
                               child: SingleChildScrollView(
                                 child: Container(
                                   height: MediaQuery.of(context).size.height*0.9,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.only(
                                         topLeft: Radius.circular(Dimensions.height20,),
                                         topRight: Radius.circular(Dimensions.height20)),
                                     color: Colors.white,
                                   ),
                                   child: Column(
                                     children: [
                                       Container(
                                         height: 520,
                                         padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,top: Dimensions.height20),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:  [
                                             PaymentOptionButton(
                                                 index: 0,
                                                 iconData: Icons.money,
                                                 title: 'Cash on delivery',
                                                 subTitle: 'you pay after getting the delivery'),
                                             SizedBox(height: Dimensions.height10,),
                                             PaymentOptionButton(
                                                 index: 1,
                                                 iconData: Icons.payment,
                                                 title: 'Online Payment',
                                                 subTitle: 'safer and faster way of payment'),
                                             SizedBox(height: Dimensions.height20,),
                                             Text("Delivery options", style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font18),),
                                             DeliveryOption(
                                                 value: "delivery",
                                                 title: "Home Delivery",
                                                 amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                                 isFree: false),
                                             DeliveryOption(
                                                 value: "take away",
                                                 title: "Take away",
                                                 amount: 10.0,
                                                 isFree: true),
                                             SizedBox(height: Dimensions.height20,),
                                             Text("Additional Notes",style: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.font18),),
                                             AppTextField(
                                                 textEditingController: _noteController,
                                                 iconData: Icons.note_add,
                                                 maxLines: true,
                                                 hintText: '')
                                           ],
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         );
                       }).whenComplete(()=> orderController.setFoodNote(_noteController.text.trim())),
                   child: Container(
                     width: double.maxFinite,
                     child: Container(
                       margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
                       padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10, left: Dimensions.height10, right: Dimensions.height10),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(Dimensions.width10),
                           color: appColors.mainColor,
                           boxShadow: [
                             BoxShadow(
                                 offset: Offset(0, 5),
                                 blurRadius: 10,
                                 color: appColors.mainColor.withOpacity(0.3)
                             )
                           ]
                       ),
                       child: Center(
                         child: LargeText(
                           text: "Payment and Delivery Options", fontWeight: FontWeight.w500, color: Colors.white, ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: Dimensions.height20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       height: Dimensions.height50,
                       margin: EdgeInsets.only(left: Dimensions.width20),
                       padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(Dimensions.width10),
                       ),
                       child: Center(child: LargeText(text: "\₹ ${controller.totalAmount.toString()}", fontWeight: FontWeight.w600)),
                     ),
                     Padding(
                       padding:  EdgeInsets.only(right: Dimensions.width20),
                       child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                               backgroundColor: appColors.mainColor,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(Dimensions.width10),
                               )
                           ),
                           onPressed: () async {
                             if (Get.find<AuthController>().userLoggedIn()) {
                               if (Get.find<LocationController>().addressList.isEmpty) {
                                 Get.toNamed(RouteHelper.getAddressPage());
                               } else {
                                 var orderController = Get.find<OrderController>();

                                 // If online payment is selected, just show snackbar and return
                                 if (orderController.paymentIndex == 1) {
                                   Get.snackbar(
                                     "Not Available",
                                     "Sorry, online payment is not available for now",
                                     backgroundColor: Colors.redAccent,
                                     colorText: Colors.white,
                                     snackPosition: SnackPosition.BOTTOM,
                                   );
                                   return; // stops further execution
                                 }

                                 // Cash on delivery workflow
                                 var location = Get.find<LocationController>().getUserAddress();
                                 var cart = Get.find<CartController>().getItems;
                                 var userController = Get.find<UserController>();
                                 if (userController.userModel == null) {
                                   await userController.getUserInfo();
                                 }
                                 var user = userController.userModel!; // safe after fetch

                                 PlaceOrderBody placeOrder = PlaceOrderBody(
                                   cart: cart,
                                   orderAmount: 100.0,
                                   orderNote: "No any Message",
                                   address: location.address,
                                   latitude: location.latitude,
                                   longitude: location.longitude,
                                   contactPersonName: user.name,
                                   contactPersonNumber: user.phone,
                                   scheduleAt: '',
                                   distance: 10.0,
                                   paymentMethod: 'Cash_on_delivery',
                                   orderType: orderController.orderType,
                                 );

                                 Get.find<OrderController>().placeOrder(placeOrder, _callback);
                               }
                             } else {
                               Get.toNamed(RouteHelper.getSignInPage());
                             }
                           },

                           child: Padding(
                             padding:  EdgeInsets.symmetric(vertical: Dimensions.width8),
                             child: LargeText(text: "CHECK OUT", fontWeight: FontWeight.w600, color: Colors.white,),
                           )),
                     )
                   ],
                 )
               ],
             ):Container()
         );
       });
     })
    );
  }

  void _callback(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreferences();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      }
      // else{
      //   //Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
      //   Get.snackbar("Not Available", "Sorry online Payment is not available for now",backgroundColor: Colors.redAccent);
      // }
    }else{
      showCustomSnackBar(message);
    }
  }

}

