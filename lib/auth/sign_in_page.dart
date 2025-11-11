import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/auth/sign_up_page.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../base/show_custom_snackbar.dart';
import '../controllers/auth_controller.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    //var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){

      String phone= phoneController.text.trim();
      String password= passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Please type your phone address", title: "Contact Number");
      }
      else if(password.isEmpty){
        showCustomSnackBar("Please type your password", title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters", title: "Password");
      }else{
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    backgroundImage: AssetImage(
                        "assets/images/logo.png"),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeText(
                      text: "Hello",
                      fontWeight: FontWeight.w600,
                      size: Dimensions.height70,),
                    Text("Sign into your account below",
                      style: TextStyle(
                          fontSize: Dimensions.font18,
                          color: Colors.grey[600]
                      ),)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //your mail
              AppTextField(
                  textEditingController: phoneController,
                  iconData: Icons.phone,
                  hintText: "Phone"),
              SizedBox(height: Dimensions.height20,),
              //your password
              AppTextField(
                textEditingController: passwordController,
                iconData: Icons.password,
                hintText: "Password",
                isObscure: true,),
              SizedBox(height: Dimensions.height20,),


              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),
                  SizedBox(width:Dimensions.width20,)

                ],
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: appColors.mainColor
                  ),
                  child: Center(
                    child: LargeText(
                      text: "Sign in",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      size: Dimensions.font25,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(

                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font18
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=> Get.to(()=> SignUpPage(), transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(
                                color: appColors.mainBlackColor,
                                fontWeight: FontWeight.w600 ,
                                fontSize: Dimensions.font18
                            )
                        )
                      ]
                  )),
            ],
          ),
        )
        :CustomLoader();
      })
    );
  }
}
