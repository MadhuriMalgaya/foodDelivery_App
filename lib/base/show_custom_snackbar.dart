
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError=true, String title="Error"}){
  Get.snackbar(title, message,
    titleText: LargeText(text: title, fontWeight: FontWeight.w500, color: Colors.white,),
    messageText: Text(message, style: const TextStyle(
      color: Colors.white
    ),),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent
  );
}