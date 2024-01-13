

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

class RouteWidget extends StatelessWidget {
  final int index;
  const RouteWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (riderController) {
        return Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(children:  [
                SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.currentLocation)),
                const SizedBox(height:45 ,width: 10,child: CustomDivider(height: 2,dashWidth: 1,axis: Axis.vertical,)),
                SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.customerRouteIcon)),
                const SizedBox(height:45 ,width: 10,child: CustomDivider(height: 2,dashWidth: 1,axis: Axis.vertical,)),
                SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.customerDestinationIcon)),
              ],),
            ),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(riderController.rideRequestList[index].from!, style: textRegular.copyWith(),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: Text(riderController.rideRequestList[index].route1!,
                      style: textRegular.copyWith(color: Theme.of(Get.context!).primaryColor.withOpacity(.75),fontSize: Dimensions.fontSizeSmall)),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                  child: SizedBox(height:20 ,width: 10,child: CustomDivider(height: 2,dashWidth: 1,axis: Axis.vertical,)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: Text(riderController.rideRequestList[index].route2!,
                      style: textRegular.copyWith(color: Theme.of(Get.context!).primaryColor.withOpacity(.75),fontSize: Dimensions.fontSizeSmall)),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Text(riderController.rideRequestList[index].to!),
              ],
            )),
          ],);
      }
    );
  }
}
