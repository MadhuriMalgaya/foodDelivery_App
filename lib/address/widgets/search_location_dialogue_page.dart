import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart'; // For Prediction

class SearchLocationDialoguePage extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchLocationDialoguePage({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField<Prediction>(
            // 🔹 The text field
            builder: (context, textEditingController, focusNode) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "Search location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
                    borderSide: BorderSide(
                      style: BorderStyle.none, width: 0
                    )
                  ),
                      hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: Dimensions.font16
                          ),
                )
              );
            },

            // 🔹 Fetch suggestions from LocationController (Google Places)
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },

            // 🔹 Build each suggestion
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding:  EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(child: Text(suggestion.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: Dimensions.font16
                    ),))
                  ],
                ),
              );
            },

            // 🔹 When user selects a suggestion
            onSelected: (Prediction suggestion)  {
              Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
