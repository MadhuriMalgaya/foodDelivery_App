import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages =[
      "google.png",
      "communication.png",
      "twitter.png"];

    void _registeration(AuthController authController){
      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String email= emailController.text.trim();
      String password= passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Please type your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Please type your contact no", title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Please type your email address", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Please type valid email address", title: "Valid Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Please type your password", title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters", title: "Password");
      }else{
        SignUpBody signUpBody= SignUpBody(
            email: email,
            password: password,
            name: name,
            phone: phone);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registeration");
            Get.offNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              //your mail
              AppTextField(
                  textEditingController: emailController,
                  iconData: Icons.email,
                  hintText: "Email"),
              SizedBox(height: Dimensions.height20,),
              //your password
              AppTextField(
                  textEditingController: passwordController,
                  iconData: Icons.password,
                  hintText: "Password", isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              //your name
              AppTextField(
                  textEditingController: nameController,
                  iconData: Icons.person,
                  hintText: "Name"),
              SizedBox(height: Dimensions.height20,),
              //your phone
              AppTextField(
                  textEditingController: phoneController,
                  iconData: Icons.phone,
                  hintText: "Phone"),
              SizedBox(height: Dimensions.height30,),

              GestureDetector(
                onTap: (){
                  _registeration(_authController);
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
                      text: "Sign up",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      size: Dimensions.font25,),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),

              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Sign up using one of the following!",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font15
                      )
                  )),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/${signUpImages[index]}",
                      height: Dimensions.height50,
                      width: Dimensions.height50,
                    ),
                  ),
                )),
              )
            ],
          ),
        )
            :const CustomLoader();
      })
    );

  }
}
