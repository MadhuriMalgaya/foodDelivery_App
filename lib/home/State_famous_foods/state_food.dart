import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/home/State_famous_foods/state_food_images_and_names.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/largeText.dart';

class StateFood extends StatelessWidget {
  final String stateName;
  final List<FoodItem> foods;

  StateFood({required this.stateName, required this.foods});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// State Name
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width30),
          child: LargeText(
            text: stateName,
            size: Dimensions.font20,
              fontWeight: FontWeight.w500
          ),
        ),

        SizedBox(height: 10),

        /// Food Items List
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          height: 140,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return Container(
                margin: EdgeInsets.only(right: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Food Image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(food.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    /// Food Name
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: LargeText(text: food.foodName,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
