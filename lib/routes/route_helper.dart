import 'package:food_delivery/Second_Page/recommended_food_order_page.dart';
import 'package:food_delivery/Second_Page/restaurants_details.dart';
import 'package:food_delivery/address/add_address_page.dart';
import 'package:food_delivery/address/pick_address_map.dart';
import 'package:food_delivery/auth/sign_in_page.dart';
import 'package:food_delivery/cart_page/cart_page.dart';
import 'package:food_delivery/home/home_page.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/payment/payment_page.dart';
import 'package:food_delivery/splash/splash_page.dart';
import 'package:food_delivery/third_page/GetBottomFoodOrderPage.dart';
import 'package:food_delivery/third_page/food_varieties.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../payment/order_success_page.dart';

class RouteHelper{
  static const String splashPage= "/splash-page";
  static const String initial= "/";
  static const String restaurantName= "/restaurant-name";
  static const String recommendedOrderPage="/recommended-order-page";
  static const String foodVarieties= '/food-varieties';
  static const String cartPage= "/cart-page";
  static const String orderPage= "/order-page";
  static const String signIn= "/sign-in";

  static const String addAddress="/add-addresss";
  static const String pickAddressMap="/pick-address";
  static const String payment='/payment';
  static const String orderSuccess='/order-successful';



  static String getSplashPage()=>'$splashPage';
  static String getInitial()=> '$initial';
  static String getRestaurantNames(int id)=> '$restaurantName?id=$id';
  static String getRecommendedOrderPage(int recommendedId, String page)=> '$recommendedOrderPage?id= $recommendedId&page=$page';
  static String getFoodVarieties(int restaurantId)=> '$foodVarieties?id=$restaurantId';
  static String getCartPage() => '$cartPage';
  static String getBottomSheetFoodOrder(int varietyId) => '$orderPage?id=$varietyId';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() =>'$addAddress';
  static String getPickAddressMap()=>'$pickAddressMap';
  static String getPaymentPage(String id, int userID)=>'$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status)=>'$orderSuccess?id=$orderID&status=$status';


  static List<GetPage> routes =[

    GetPage(name: splashPage, page: ()=> SplashScreen()),


    GetPage(name: initial, page: () {
          return HomeScreen();
    }, transition: Transition.fade),


    GetPage(name: signIn, page: (){
      return SignInPage();
    }, transition: Transition.fade),


    GetPage(name: restaurantName,
        page: (){
          int foodId= int.parse(Get.parameters['id']!);
          return RestaurantsDetails(productId: foodId);
    },
  transition: Transition.fadeIn
   ),


    GetPage(
        name: recommendedOrderPage,
        page: (){
          int recommendedId = int.parse(Get.parameters['id']!);
          var page= Get.parameters["page"];
          return RecommendedFoodOrderPage(recommendedId : recommendedId, page: page!,);
        }),


    GetPage(name: foodVarieties,
        page: (){
      int restaurantId = int.parse(Get.parameters['id']!);
      int varietyId = int.parse(Get.parameters['id']!);
      return FoodVarieties(restaurantId: restaurantId, foodVarietyId: varietyId,) ;
    },transition: Transition.fadeIn),


    GetPage(
      name: orderPage,
      page: () {
        int varietyId = int.parse(Get.parameters['id']!);
        return GetBottomFoodOrderPage(foodVarietyId: varietyId);
      },
    ),


    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn),

    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    }),

    GetPage(
        name: pickAddressMap,
        page: (){
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),

    GetPage(name: payment, page: ()=> PaymentScreen(
      orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!), 
          userId: int.parse(Get.parameters['userID']!)),)
    ),
    GetPage(name: orderSuccess, page: ()=> OrderSuccessPage(
      orderID: Get.parameters['id']!, status:Get.parameters['status'].toString().contains("success")?1:0,


    ))

  ];
}