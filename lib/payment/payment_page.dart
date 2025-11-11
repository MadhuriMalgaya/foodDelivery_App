import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/order_model.dart';
import '../routes/route_helper.dart';
import '../utils/app_constants.dart';
import '../utils/dimensions.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  final bool isCOD;
  PaymentScreen({required this.orderModel, this.isCOD = false});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  late final WebViewController _controller;
  bool _canRedirect = true;
  bool _isLoading = true;

  @override
  @override
  void initState() {
    super.initState();

    if (widget.isCOD) {
      // COD handled before, but keep safety redirect
      Future.delayed(Duration.zero, () {
        Get.offNamed(RouteHelper.getOrderSuccessPage(
            widget.orderModel.id.toString(), 'success'));
      });
      return;
    }

    // 👇 For now, no payment gateway implemented
    Future.delayed(Duration.zero, () {
      Get.snackbar("Online Payment", "No online payment available right now",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      // Optional: redirect to success as failed
      Get.offNamed(RouteHelper.getOrderSuccessPage(
          widget.orderModel.id.toString(), 'fail'));
    });
  }


  void _handleRedirect(String url) {
    if (_canRedirect) {
      bool isSuccess = url.contains('payment-success');
      bool isFailed = url.contains('payment-fail');

      if (isSuccess || isFailed) _canRedirect = false;

      if (isSuccess) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(
            widget.orderModel.id.toString(), 'success'));
      } else if (isFailed) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(
            widget.orderModel.id.toString(), 'fail'));
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // If COD, show a loading while redirecting
    if (widget.isCOD) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Payment"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await _exitApp(context)) Navigator.pop(context);
            },
          ),
          backgroundColor: appColors.mainColor,
        ),
        body: Center(
          child: Container(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
