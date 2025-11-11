import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/icons.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();

    }
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              // profile icon
              IconsData(iconData: Icons.person,
                backgroundColor: appColors.mainColor,
                iconColor: Colors.white,
                iconsize: Dimensions.height70 ,
                size: Dimensions.height150- Dimensions.height10,
              ),
              SizedBox(height: Dimensions.height20,),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // name
                      AccountWidget(
                          iconsData: IconsData(
                            iconData: Icons.person,
                            backgroundColor: appColors.mainColor,
                            iconColor: Colors.white,
                            iconsize: Dimensions.height25,
                            size: Dimensions.height50,),

                          largeText: LargeText(
                            text: userController.userModel!.name,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            size:  Dimensions.font18,)),
                      SizedBox(height: Dimensions.height20,),
                      // phone
                      AccountWidget(
                          iconsData: IconsData(
                            iconData: Icons.phone,
                            backgroundColor: appColors.yellowColor,
                            iconColor: Colors.white,
                            iconsize: Dimensions.height25,
                            size: Dimensions.height50,),

                          largeText: LargeText(
                            text: userController.userModel!.phone,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            size:  Dimensions.font18,)),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                          iconsData: IconsData(
                            iconData: Icons.mail,
                            backgroundColor: appColors.yellowColor,
                            iconColor: Colors.white,
                            iconsize: Dimensions.height25,
                            size: Dimensions.height50,
                          ),

                          largeText: LargeText(
                            text: userController.userModel!.email,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            size:  Dimensions.font18,)),
                      SizedBox(height: Dimensions.height20,),
                      // locations
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userLoggedIn&&locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                iconsData: IconsData(
                                  iconData: Icons.location_on,
                                  backgroundColor: appColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconsize: Dimensions.height25,
                                  size: Dimensions.height50,),

                                largeText: LargeText(
                                  text: "Fill in your address",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  size:  Dimensions.font18,)
                            ),

                          );
                        }else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(
                                iconsData: IconsData(
                                  iconData: Icons.location_on,
                                  backgroundColor: appColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconsize: Dimensions.height25,
                                  size: Dimensions.height50,),

                                largeText: LargeText(
                                  text: "Your address",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  size:  Dimensions.font18,)
                            ),

                          );
                        }
                      }),

                      SizedBox(height: Dimensions.height20,),
                      // message
                      AccountWidget(
                          iconsData: IconsData(
                            iconData: Icons.message,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconsize: Dimensions.height25,
                            size: Dimensions.height50,),

                          largeText: LargeText(
                            text: "Messages",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            size:  Dimensions.font18,)),
                      SizedBox(height: Dimensions.height20,),
                      // logout
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()) {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                          else{
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                            iconsData: IconsData(
                              iconData: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconsize: Dimensions.height25,
                              size: Dimensions.height50,),

                            largeText: LargeText(
                              text: "Logout",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              size:  Dimensions.font18,)),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        CustomLoader())
        :Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.30,
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: DecorationImage(
                          image: AssetImage("assets/images/bicycle.png"),
                          fit: BoxFit.cover)
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height100,
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: appColors.mainColor
                    ),
                    child: Center(
                      child: LargeText(
                          text: "Sign in", fontWeight: FontWeight.w500, color: Colors.white, size: Dimensions.font20,),
                    ),
                  ),
                ),
              ],
            )));
      })
    );
  }
}
