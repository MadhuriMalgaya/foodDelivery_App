import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/helper/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  final CartController cart;

  PopularProductController({required this.popularProductRepo,  required this.cart,});

  List<Products> _popularProductList = [];
  List<Products> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=0;
  int get quantity => _quantity;

  int _inCartItems=0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularproductList();
    if (response.statusCode == 200) {
      _popularProductList = ProductModel.fromJson(response.body).products;
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement){
      //print("incre");
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
    }
    else{
      //print("decre");
      _quantity = checkQuantity(_quantity -1);
    }
    update();
  }
  int checkQuantity (int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item Count","You can't reduce more",
      backgroundColor: appColors.mainColor,
      colorText: Colors.white
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>30){
      Get.snackbar("Item Count","You can't add more",
          backgroundColor: appColors.mainColor,
          colorText: Colors.white);
      return 30;
    }else{
      return quantity;
    }
  }
  void initProduct(Varieties product, CartController cart){
    _quantity = 0;
    _inCartItems=0;

    var exist = false;
    exist = cart.existInCart(product);
    //print("exist or not "+exist.toString());
    if(exist){
      _inCartItems= cart.getQuantity(product);
    }
    //print("the quantity in the cart is: "+ inCartItems.toString());
  }

  void addItems(Varieties product) {
      cart.addItem(product, _quantity);
      _quantity =0;
      _inCartItems=cart.getQuantity(product);
      cart.items.forEach((key, value){
        //print("The id is : "+ value.id.toString()+ "The quantity is: "+value.quantity.toString());
      });

      update();
  }

  int get totalItems{
    return cart.totalItems;
  }

 List<CartModel> get getItems{
    return cart.getItems;
 }
}
