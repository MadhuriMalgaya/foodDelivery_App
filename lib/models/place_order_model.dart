import 'package:food_delivery/models/cart_model.dart';

class PlaceOrderBody {
  List<CartModel>? _cart;
  late double _orderAmount;
  late String _orderNote;
  late double _distance;
  late String _address;
  late String _latitude;
  late String _longitude;
  late  String _contactPersonName;
  late String _contactPersonNumber;
  late String _orderType;
  late String _paymentMethod;

  PlaceOrderBody(
      {required List<CartModel> cart,
        required double orderAmount,
        required double distance,
        required String scheduleAt,
        required String orderNote,
        required String address,
        required String latitude,
        required String longitude,
        required String contactPersonName,
        required String contactPersonNumber,
        required String orderType,
        required String paymentMethod
      }){
    this._cart = cart;
    this._orderAmount = orderAmount;
    this._orderNote = orderNote;
    this._distance = distance;
    this._address = address;
    this._latitude = latitude;
    this._longitude = longitude;
    this._contactPersonName = contactPersonName;
    this._contactPersonNumber = contactPersonNumber;
    this._orderType=orderType;
    this._paymentMethod=paymentMethod;
  }

  List<CartModel> get cart => _cart!;

  double get orderAmount => _orderAmount;

  String get orderNote => _orderNote;

  double get distance => _distance;

  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get contactPersonName => _contactPersonName;
  String get contactPersonNumber => _contactPersonNumber;

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(new CartModel.fromJson(v));
      });
    }

    _orderAmount = json['order_amount'];

    _orderNote = json['order_note'];

    _distance = json['distance'];

    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _contactPersonName = json['contact_person_name'];
    _contactPersonNumber = json['contact_person_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (_cart != null) {
      data['cart'] = _cart!.map((item) {
        // Decide source dynamically for each item
        String itemSource;
        if (item.product != null) {
          itemSource = 'popular';
        } else if (item.recommendedProduct != null) {
          itemSource = 'recommended';
        } else {
          itemSource = 'normal'; // fallback
        }

        // Return map for backend
        return {
          'id': item.id,
          'name': item.name,
          'price': item.price,
          'img': item.img,
          'quantity': item.quantity,
          'description': item.description,
          'source': itemSource,
        };
      }).toList();
    }

    data['order_amount'] = _orderAmount;
    data['order_note'] = _orderNote;
    data['distance'] = _distance;
    data['address'] = _address;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    data['contact_person_name'] = _contactPersonName;
    data['contact_person_number'] = _contactPersonNumber;
    data['order_type']= _orderType;
    data['payment_method']=this._paymentMethod;
    return data;
  }


}