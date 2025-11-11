import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/address/widgets/search_location_dialogue_page.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../models/address_model.dart';

class PickAddressMap extends StatefulWidget {

  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({super.key,
  required this.fromSignup,
  required this.fromAddress,
  this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition=LatLng(30.753872, 76.640126);
      _cameraPosition=CameraPosition(target: _initialPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition=LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"])
        );
        _cameraPosition=CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(initialCameraPosition: CameraPosition(
                        target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition){
                        _cameraPosition=cameraPosition;
                      },
                      onCameraIdle: (){
                        Get.find<LocationController>().updatePosition(_cameraPosition, false);
                      },
                     onMapCreated: (GoogleMapController mapController){
                      _mapController = mapController;
                      if(!widget.fromAddress){

                      }
                },),
                    Center(
                      child: !locationController.loading?Image.asset("assets/images/pick.png",
                      height: 50, width: 50,)
                          :CircularProgressIndicator()
                    ),
                    
                    Positioned(
                      top: Dimensions.height45,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: InkWell(
                          onTap: ()=> Get.dialog(SearchLocationDialoguePage(mapController: _mapController)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                            height: Dimensions.height50,
                            decoration: BoxDecoration(
                              color: appColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.width10)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_on, size: Dimensions.font25, color: Colors.white,),
                                Expanded(child: Text(
                                  '${locationController.pickPlacemark.name??''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                SizedBox(width: Dimensions.width10,),
                                Icon(Icons.search, size: Dimensions.width25, color: Colors.white,)
                              ],
                            ),
                          ),
                        )
                    ),
                    Positioned(
                      bottom: Dimensions.height80,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: locationController.isLoading?Center(child: CircularProgressIndicator(),)
                            :CustomButton(
                            buttonText: locationController.inZone?widget.fromAddress?"Pick Address": "Pick Location":"Service is not available in your area",
                            onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                              if(locationController.pickPosition.latitude!=0&&
                                  locationController.pickPlacemark.name!=null){
                                if(widget.fromAddress){
                                  if(widget.googleMapController!=null){
                                    print("Now you can clicked on this");
                                    widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                        locationController.pickPosition.latitude,
                                        locationController.pickPosition.longitude
                                    ))));
                                    locationController.setAddAddressData();
                                  }
                                  Get.toNamed(RouteHelper.getAddressPage());
                                  locationController.saveUserAddress(
                                    AddressModel(
                                      addressType: "home",
                                      address: locationController.pickPlacemark.name,
                                      latitude: locationController.pickPosition.latitude.toString(),
                                      longitude: locationController.pickPosition.longitude.toString(),
                                    ),
                                  );
                                }
                              }
                            }
                        )
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }
}
