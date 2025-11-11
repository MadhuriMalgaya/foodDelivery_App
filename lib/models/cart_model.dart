import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/recommended_model.dart';

class CartModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? quantity;
  bool? isExit;
  String? time;
  String? img;
  Varieties? product;
  RecommendedProduct? recommendedProduct;

  CartModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
    this.quantity,
    this.time,
    this.isExit,
    this.product,
    this.recommendedProduct
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExit = json['isExit'];

    if (json['product'] != null) {
      product = Varieties.fromJson(json['product']);
    }
    if (json['recommendedProduct'] != null) {
      recommendedProduct = RecommendedProduct.fromJson(json['recommendedProduct']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExit": isExit,
      "time": time,
      "description": description,
    };

    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (recommendedProduct != null) {
      data['recommendedProduct'] = recommendedProduct!.toRecommendedJson();
    }

    return data;
  }
}
