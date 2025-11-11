import 'package:flutter/material.dart';
import 'package:food_delivery/helper/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/recommended_model.dart';
import 'package:get/get.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(Varieties product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          description: value.description,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          product: product,
          isExit: true,

        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    }
    else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          //print("Adding item: ${product.id}, quantity: $quantity");
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            description: product.description,
            time: DateTime.now().toString(),
            isExit: true,
            product: product,

          );
        });
      } else {
        Get.snackbar(
            "Item Count", "You should at least add an item in the card!",
            backgroundColor: appColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Varieties product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(Varieties product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  // for recommended products

  void addRecommendedItem(RecommendedProduct product, int quantity) {
    var totalQuantity=0;
    if(_items.containsKey(product.id!)) {
      _items.update(product.id!,(value){

        totalQuantity=value.quantity!+quantity;

        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            description: value.description,
            quantity: value.quantity!+quantity,
            isExit: true,
            recommendedProduct: product,
            time: DateTime.now().toString()
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else {
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              description: product.description,
              quantity: quantity,
              isExit: true,
              recommendedProduct: product,
              time: DateTime.now().toString()
          );
        });
      }else{
        Get.snackbar("Item Count","You should at least add an item in the card!",
        backgroundColor: appColors.mainColor,colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();

  }

    bool existInCarts(RecommendedProduct product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
    }

    int getRecommendedQuantity(RecommendedProduct product){
       var quantity=0;
       if(_items.containsKey(product.id)){
         _items.forEach((key, value){
           if(key==product.id){
             quantity=value.quantity!;
           }
         });
       }
       return quantity;
    }

    // for cart

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("length: " + storageItems.length.toString());

    for (int i = 0; i < storageItems.length; i++) {
      final cartItem = storageItems[i];

      if (cartItem.product != null && cartItem.product!.id != null) {
        _items.putIfAbsent(cartItem.product!.id!, () => cartItem);
      } else if (cartItem.recommendedProduct != null && cartItem.recommendedProduct!.id != null) {
        _items.putIfAbsent(cartItem.recommendedProduct!.id!, () => cartItem);
      }
    }
  }


  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharedPreferences(){
    cartRepo.removeCartSharedPreferences();
  }
}

