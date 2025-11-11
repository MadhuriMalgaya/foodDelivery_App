
class ProductModel {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<Products> _products;
  List<Products> get products => _products;

  ProductModel({required totalSize, required typeId, required offset, required products}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset=offset;
    this._products=products;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <Products>[];
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
  }

}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;
  List<Restaurants>? restaurants;
  List<Varieties>? varieties;

  Products(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId,
        this.restaurants,
        this.varieties});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    if (json['varieties'] != null) {
      varieties = <Varieties>[];
      json['varieties'].forEach((v) {
        varieties!.add(new Varieties.fromJson(v));
      });
    }
  }
}

class Restaurants {
  int? id;
  int? foodId;
  String? name;
  String? address;
  double? rating;
  String? img;
  String? createdAt;
  String? updatedAt;

  Restaurants({this.id,
    this.foodId,
    this.name,
    this.address,
    this.rating,
    this.img,
    this.createdAt,
    this.updatedAt});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    name = json['name'];
    address = json['address'];
    if (json['rating'] != null) {
      rating = double.tryParse(json['rating'].toString());
    }
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
class Varieties {
  int? id;
  int? foodId;
  int? restaurantId;
  String? name;
  String? description;
  int? price;
  int? quantity;
  bool? isExit;
  String? time;
  String? img;
  String? createdAt;
  String? updatedAt;

  Varieties({this.id,this.foodId,this.restaurantId, this.name, this.description, this.price, this.img, this.quantity, this.time, this.isExit,this.createdAt, this.updatedAt});

  Varieties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExit =json['isExit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String,dynamic> toJson(){
    return{
      "id" : this.id,
      "name" : this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist" :this.isExit,
      "time" : this.time,
      "description" : this.description,
    };
  }

}





