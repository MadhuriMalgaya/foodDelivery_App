class RecommendedProductsModel {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<RecommendedProduct> _products;

  List<RecommendedProduct> get products => _products;

  RecommendedProductsModel(
      {required totalSize, required typeId, required offset, required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  RecommendedProductsModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <RecommendedProduct>[];
      json['products'].forEach((v) {
        products.add(new RecommendedProduct.fromJson(v));
      });
    }
  }
}
class RecommendedProduct {
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

  RecommendedProduct(
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
      });

  RecommendedProduct.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toRecommendedJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "img": this.img,
      "location": this.location,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
      "type_id": this.typeId,

    };
  }
}