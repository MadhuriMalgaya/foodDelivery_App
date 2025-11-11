import 'package:flutter/material.dart';
import 'package:food_delivery/address/pick_address_map.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/largeText.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName =TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      30.753872, 76.640126), zoom: 17);

  late LatLng _initialPosition =LatLng(
      30.753872, 76.640126);

  @override
  void initState(){
    super.initState();
    _isLogged= Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){

      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition= LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Address"),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null && _contactPersonName.text.isEmpty){
           _contactPersonName.text = userController.userModel!.name;
           _contactPersonNumber.text=userController.userModel!.phone;
           if(Get.find<LocationController>().addressList.isNotEmpty){
             _addressController.text= Get.find<LocationController>().getUserAddress().address;
           }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("address in my view: "+_addressController.text);


          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5, top: Dimensions.width5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.width5),
                      border: Border.all(
                          width: 2, color: appColors.mainColor
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                        onTap: (latlng){
                            Get.toNamed(RouteHelper.getPickAddressMap(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,
                            ));
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position)=> _cameraPosition=position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                          if(Get.find<LocationController>().addressList.isEmpty){
                            locationController.getCurrentLocation(true, mapController: controller);
                          }
                        },
                      )
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20, top: Dimensions.width20),

                  child: SizedBox(height: Dimensions.height50, child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: locationController.addressTypeList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        locationController.setAddressTypeIndex(index);
                      },
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.width5),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: Icon(
                          index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                          color: locationController.addressTypeIndex==index?
                          appColors.mainColor:Theme.of(context).disabledColor,
                        )
                      ),
                    );
                  }),),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width25),
                  child: LargeText(text: "Delivery Address", fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _addressController, iconData: Icons.map, hintText: "your address"),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width25),
                  child: LargeText(text: "Contact Name", fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonName, iconData: Icons.person, hintText: "your name"),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width25),
                  child: LargeText(text: "Contact Number", fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonNumber, iconData: Icons.phone, hintText: "your phone")
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Container(
          height: Dimensions.height100,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width10),
                      )
                  ),
                  onPressed: (){
                    AddressModel _addressModel = AddressModel(addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString()
                    );
                    locationController.addAddress(_addressModel).then((response){
                      if(response.isSuccess){
                        Get.toNamed(RouteHelper.getInitial());
                        Get.snackbar("Address","Added Successfully");
                      }else{
                        Get.snackbar("Address","Couldn't save address");
                      }
                    });
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.width15),
                    child: LargeText(text: "Save Address", fontWeight: FontWeight.w500, color: Colors.white,),
                  )),
            ],
          ),
        );
      }),
    );
  }
}
