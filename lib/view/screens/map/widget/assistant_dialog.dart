import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';

class AssistantDialog extends StatelessWidget {
  const AssistantDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              Text('you_should_know'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(radius: 3,backgroundColor: Theme.of(context).primaryColor),
                ),
                Expanded(child: Text('you_have_to_reach_your_pickup_point_in_counting_time_to_increase_your_success_rate'.tr,
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),))
              ],),

              Center(
                child: Container(width: 250,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),

                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(Images.flag)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(Images.arrowBig)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.rRoute)),
                    ),

                  ],),
                ),
              ),

              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor),
                ),
                Expanded(child: Text('you_have_to_reach_your_pickup_point_in_counting_time_to_increase_your_success_rate'.tr,
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),))
              ],),


              Center(child: SizedBox(width: Dimensions.iconSizeDoubleExtraLarge,child: Image.asset(Images.campusIcon))),

              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor),
                ),
                Expanded(child: Text('you_have_to_reach_your_pickup_point_in_counting_time_to_increase_your_success_rate'.tr,
                  style: textRegular.copyWith(color: Theme.of(context).primaryColor),))
              ],),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Center(child: SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.trafficIcon))),
              ),

            ],),
          ),
           Positioned(top: 10,right: 10,
              child: GestureDetector(
                onTap: (){
                  Get.find<RiderMapController>().toggleAssistant();
                  Get.back();
                },
                  child:  Icon(Icons.clear, color: Theme.of(context).primaryColor,)))
        ],
      ),
    );
  }
}
