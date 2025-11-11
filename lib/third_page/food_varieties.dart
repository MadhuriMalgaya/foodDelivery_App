import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:get/get.dart';
import '../routes/route_helper.dart';
import '../widgets/AppIcon.dart';
import 'GetBottomFoodOrderPage.dart';

class FoodVarieties extends StatefulWidget {
  final int restaurantId;
  final int foodVarietyId;
  const FoodVarieties({super.key, required this.restaurantId,required this.foodVarietyId});


  @override
  State<StatefulWidget> createState() => _FoodVarieties();
}

class _FoodVarieties extends State<FoodVarieties> {

  late final ScrollController _scrollController;
  bool _showTitle = false;
  final double _expandedHeight = Dimensions.height200;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final threshold = _expandedHeight - kToolbarHeight;
        final shouldShow =
            _scrollController.hasClients && _scrollController.offset >= threshold;
        if (shouldShow != _showTitle) {
          setState(() => _showTitle = shouldShow);
        }
      });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    var productVarieties = Get.find<PopularProductController>().popularProductList;
    var restaurant = productVarieties
        .expand((product) => product.restaurants ?? [])
        .firstWhere((r) => r.id == widget.restaurantId);
    var product = productVarieties.firstWhere(
            (p) => (p.restaurants?.any((r) => r.id == widget.restaurantId) ?? false));
    var varieties = product.varieties
        ?.where((v) => v.restaurantId == widget.restaurantId)
        .toList() ?? [];



    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            leading: GetBuilder<PopularProductController>(builder: (popularProducts){
             return GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios),
              );
            }),
            actions: [
              GestureDetector(

                  child: GetBuilder<PopularProductController>(builder: (controller){
                    return Container(
                      margin: EdgeInsets.only(right: Dimensions.width10),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap : (){
                              if(controller.totalItems >= 1) {
                                Get.toNamed(RouteHelper.getCartPage());
                              }
                             },
                            child: AppIcon(
                              iconData: Icons.shopping_cart_outlined,
                            ),
                          ),
                          // Only show badge if totalItems >= 1
                              controller.totalItems >= 1
                              ? Positioned(
                               right: 0,
                               top: 0,
                                child: Container(
                                  height: Dimensions.width15,
                                  width: Dimensions.width15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: appColors.mainColor, // badge background
                                  ),
                                  child: Center(
                                    child: LargeText(
                                      text: Get.find<PopularProductController>().totalItems.toString(),
                                      color: Colors.white,
                                      size: Dimensions.height10,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    );

                  }),
                )
            ],
            title: AnimatedOpacity(
              opacity: _showTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: Align(
                alignment: Alignment(-(Dimensions.align), 0),
                child: Text(restaurant.name ?? "Restaurant"),
              ),
            ),
            expandedHeight: Dimensions.height200,
            flexibleSpace: FlexibleSpaceBar(
              background: _SliverAppBarSection(restaurant),
            ),
          ),
          // Divider
          SliverToBoxAdapter(
            child: Divider(thickness: Dimensions.divider, color: Colors.grey),
          ),
          // Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width10),
              child: Text(
                "Best in Pizza",
                style: TextStyle(fontSize: Dimensions.font18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Pizza List
          varieties.isNotEmpty?
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final variety = varieties[index];

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.85,
                              child: GetBottomFoodOrderPage(foodVarietyId: variety.id!),
                            );
                          },
                        );
                      },
                      child: GetBuilder<PopularProductController>(builder: (popularProduct){
                        return Container(
                          margin:  EdgeInsets.symmetric(horizontal: Dimensions.height20, vertical: Dimensions.height10),
                          padding:  EdgeInsets.all(Dimensions.height12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.width15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:Dimensions.height150,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.height12),
                                    child: Image.network(
                                      "${AppConstants.BASE_URL}/uploads/${variety.img}",
                                      height: Dimensions.height120,
                                      width: Dimensions.height120,
                                      fit: BoxFit.cover,
                                      // Shows circular progress indicator while loading
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      // Shows fallback if image fails to load
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Container(
                                          height: Dimensions.height120,
                                          width: Dimensions.height120,
                                          color: Colors.grey.shade200,
                                          child: Icon(Icons.image_not_supported, color: Colors.grey, size: Dimensions.height40),
                                        );
                                      },
                                    ),
                                  ),


                                ),
                              ),
                               SizedBox(width: Dimensions.height12),
                              // Texts
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/veg.png", height: Dimensions.width20, width: Dimensions.width20),
                                    Text(
                                      variety.name ?? "",
                                      style: TextStyle(
                                        fontSize: Dimensions.font18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                     SizedBox(height: Dimensions.height8),
                                    // Price Row
                                    Row(
                                      children: [
                                        Icon(Icons.currency_rupee, size: Dimensions.icon18, color: Colors.red),
                                        SizedBox(width: Dimensions.height4,),
                                        Expanded(
                                          child: Text(
                                            "${variety.price}",
                                            style: TextStyle(fontSize: Dimensions.font16, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: Dimensions.height8),
                                    // Description Text
                                    Text(
                                      variety.description ?? "No description",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Dimensions.font13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ),
                    // Divider
                    if (index != varieties.length - 1)
                      Divider(
                        thickness: Dimensions.height2,
                        color: Colors.grey.shade300,
                        indent: Dimensions.height20,
                        endIndent: Dimensions.height20,
                      ),
                  ],
                );
              },
              childCount: varieties.length,
            ),
          ) :
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: NoDataPage(
                text: "No product!",
                imgPath: "assets/images/emptyBag.png",
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
            return SizedBox(
              height: Dimensions.height70,
              child: Padding(
                padding:  EdgeInsets.all(Dimensions.width10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: Dimensions.width5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.search, color: appColors.mainColor, size: Dimensions.icon25),
                      SizedBox(width: Dimensions.width10),
                      Text(
                        "Search Pizza",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),

    );
  }

  Widget _SliverAppBarSection(Restaurants restaurants) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: Dimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Dimensions.height30,
            width: Dimensions.height110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: Color(0xFFCDE5CD),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width8),
                  child: Icon(Icons.energy_savings_leaf, color: Colors.green),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Text(
                    "Pure Veg",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurants.name ?? "Restaurant",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.height2),
                margin: EdgeInsets.only(right: Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.width10),
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                      child: Text(
                        "${restaurants.rating}",
                        style: TextStyle(
                            fontSize: Dimensions.font16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Icon(Icons.star, color: Colors.white, size: Dimensions.font16),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: Dimensions.font18,),
              Padding(
                padding:  EdgeInsets.only(left: Dimensions.width5),
                child: Text(
                  "1.5 km",
                  style: TextStyle(fontSize: Dimensions.font13),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.width5),
                padding: EdgeInsets.only(left: Dimensions.width5),
                child: LargeText(text: ".", color: Colors.black, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:  EdgeInsets.only(left:Dimensions.width5),
                child: Text(
                  "Gillco Valley",
                  style: TextStyle(fontSize: Dimensions.font13),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.watch_later_outlined, size: Dimensions.font18,),
              Padding(
                padding:  EdgeInsets.only(left: Dimensions.width5),
                child: Text(
                  "20-25 mins",
                  style: TextStyle(fontSize: Dimensions.font13),
                ),
              ),
              Container(
                margin:  EdgeInsets.only(bottom: Dimensions.width5),
                padding: EdgeInsets.only(left: Dimensions.width5),
                child: LargeText(text: ".", color: Colors.black, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width5),
                child: Text(
                  "Schedule for later",
                  style: TextStyle(fontSize: Dimensions.font13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
