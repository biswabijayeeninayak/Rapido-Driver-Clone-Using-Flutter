import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class CustomerInfoWidget extends StatelessWidget {
  final int index;
  final bool fromTripDetails;
  const CustomerInfoWidget({Key? key, required this.index,  this.fromTripDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (riderController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
          child: Row(children: [
            Stack(
              children: [
                Container(transform: Matrix4.translationValues(-3, -3, 0),
                    child: CircularPercentIndicator(radius: 28, percent: .75,lineWidth: 1,backgroundColor: Colors.transparent, progressColor: Theme.of(Get.context!).primaryColor,)),
                ClipRRect(borderRadius : BorderRadius.circular(100),
                    child: const CustomImage(width: 50,height: 50,image: '')),

              ],
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(riderController.rideRequestList[index].customer!.name!),
                Row(
                  children: [
                    Icon(Icons.star_rate_rounded, color: Theme.of(Get.context!).primaryColor,size: Dimensions.iconSizeMedium,),
                    Text(riderController.rideRequestList[index].customer!.name!),
                  ],
                ),

              ],)),
            fromTripDetails?const SizedBox():
            Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('given_fare'.tr, style: textMedium.copyWith(color: Theme.of(Get.context!).primaryColor),),
                Text(PriceConverter.convertPrice(Get.context!, double.parse(riderController.rideRequestList[index].customer!.fair!)),
                    style: textSemiBold.copyWith(color: Theme.of(Get.context!).primaryColor)),
              ],)
          ],),
        );
      }
    );
  }
}
