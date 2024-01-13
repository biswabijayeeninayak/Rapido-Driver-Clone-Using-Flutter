import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

class ServiceHourAndStatusWidget extends StatelessWidget {
  const ServiceHourAndStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<RideController>(
      builder: (rideController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
          child: DottedBorder(
            dashPattern: const [1,1],
            borderType: BorderType.RRect,
            color: Theme.of(context).primaryColor,
            radius: const Radius.circular(Dimensions.paddingSizeDefault),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('${'total'.tr} ${rideController.activityName} ${'hour'.tr}',
                      style: textMedium.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: Dimensions.fontSizeLarge),),
                    Text('5.45 hr', style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: rideController.hourActivityIndex == 0?
                      Colors.orange[300]:
                      rideController.hourActivityIndex == 1?
                      Theme.of(context).primaryColor:
                      rideController.hourActivityIndex == 2?
                      Theme.of(context).colorScheme.tertiaryContainer:
                      Theme.of(context).colorScheme.secondaryContainer,
                    ),)
                  ],),
                ),),
            ),
          ),
        );
      }
    );
  }
}
