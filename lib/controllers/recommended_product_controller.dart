import 'package:flutter/material.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/recommended_model.dart';
import 'package:get/get.dart';
import '../helper/data/repository/recommended_product_repo.dart';
import '../models/cart_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  final CartController cart;

  RecommendedProductController(
      {required this.recommendedProductRepo, required this.cart,});

  List<RecommendedProduct> _recommendedProductList = [];
  List<RecommendedProduct> get recommendedProductList => _recommendedProductList;



  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedproductList() async {
    Response response = await recommendedProductRepo
        .getRecommendedproductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(RecommendedProductsModel
          .fromJson(response.body)
          .products);
      _isLoaded = true;
      update();
    } else {
      print("could not get products");
    }
  }

  void setQuantity(bool isIncrement) {
    //print("incre");
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    }
    else {
      //print("decre");
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can't reduce more",
          backgroundColor: appColors.mainColor,
          colorText: Colors.white
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 30) {
      Get.snackbar("Item Count", "You can't add more",
          backgroundColor: appColors.mainColor,
          colorText: Colors.white);
      return 30;
    } else {
      return quantity;
    }
  }

  void initProduct(RecommendedProduct product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;


    var exist=false;
    exist=  cart.existInCarts(product);
    //print("exist or not "+exist.toString());
    if(exist){
      _inCartItems=cart.getRecommendedQuantity(product);
    }
    print(_inCartItems.toString());
  }

  void addItems(RecommendedProduct product){
      cart.addRecommendedItem(product, _quantity);
      _quantity=0;
      _inCartItems=cart.getRecommendedQuantity(product);
      cart.items.forEach((key, value){
        //print("The id is : "+ value.id.toString()+ "The quantity is: "+value.quantity.toString());
      });

      update();

  }

  int get totalItems{
    return cart.totalItems;
  }
}


//     var exist = false;
//     exist = cart.existInCarts(product);
//     //print("exist or not "+exist.toString());
//     if(exist){
//       _inCartItems= cart.getRecommendedQuantity(product);
//     }
//     //print("the quantity in the cart is: "+ inCartItems.toString());
//   }
//
//   void addItems(RecommendedProduct product) {
//     cart.addRecommendedItem(product, _quantity);
//     _quantity =0;
//     _inCartItems=cart.getRecommendedQuantity(product);
//     cart.items.forEach((key, value){
//       //print("The id is : "+ value.id.toString()+ "The quantity is: "+value.quantity.toString());
//     });
//
//     update();
//   }
//
//   int get totalItems{
//     return cart.totalItems;
//   }
//
//   List<CartModel> get getItems{
//     return cart.getItems;
//   }
//
//
//
//
