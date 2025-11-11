import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedproductList() async{
    return await apiClient.getData(AppConstants.Recommended_PRODUCT_URI);
  }
}