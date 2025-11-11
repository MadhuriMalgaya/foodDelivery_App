import 'package:food_delivery/helper/data/repository/order_repo.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  bool _isLoading=false;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  bool get isLoading=>_isLoading;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex=0;
  int get paymentIndex =>_paymentIndex;
  String _orderType= "delivery";
  String get orderType=> _orderType;

  String _foodNote=" ";
  String get foodNote=>_foodNote;


  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);

    _isLoading = false;

    if (response.statusCode == 200) {
      String message = response.body['message'] ?? "Order placed";
      String orderID = response.body['order_id']?.toString() ?? '';

      if(orderID.isEmpty){
        callback(false, "Order ID not returned by server", '-1');
      } else {
        callback(true, message, orderID);
      }
    } else {
      callback(false, response.statusText ?? "Failed", '-1');
    }
  }
  Future<void> getOrderList() async{
    _isLoading=true;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode==200){
      _historyOrderList=[];
      _currentOrderList=[];
      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus=='pending' ||
            orderModel.orderStatus=='accepted' ||
            orderModel.orderStatus=='processing' ||
            orderModel.orderStatus=='handover' ||
            orderModel.orderStatus=='picked_up'
        ){
          _currentOrderList.add(orderModel);
        }
        else{
          _historyOrderList.add(orderModel);
        }
      });
    }else{
      _historyOrderList=[];
      _currentOrderList=[];
    }
    _isLoading=false;
    print("The length of the orders is: "+_currentOrderList.length.toString());
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex=index;
    update();
  }
  void setDelivery(String type){
    _orderType=type;
    update();
  }
  void setFoodNote(String note){
    _foodNote=note;
  }
}