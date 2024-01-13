import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_slider_button.dart';

class ActiveYourPickWidget extends StatelessWidget {
  const ActiveYourPickWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
        builder: (riderMapController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [

              Container(
                height:  50,
                margin:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                  color: Theme.of(context).cardColor,),


                child: Transform.rotate(
                  angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: SliderButton(
                      width: Get.width - 62,
                      dismissible: false,
                      action: () {
                        riderMapController.toggleActivatedPack();
                      },

                      label: Text('swipe_right_to_active'.tr,
                        style: textMedium.copyWith(
                            color: Theme.of(context).primaryColor),),
                      dismissThresholds: 0.5,
                      icon: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.sliderIcon),
                      )),

                      radius: 100,
                      boxShadow: const BoxShadow(blurRadius: 0.0),
                      buttonColor: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).cardColor,
                      baseColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Text.rich(TextSpan(
                children: [
                  TextSpan(text: 'swipe_to'.tr),
                  const TextSpan(text: ' '),
                  TextSpan(text :'active_your_pack'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                  const TextSpan(text: ' '),
                  TextSpan(text: 'time_trip'.tr),
                ]
              )),

            ]),
          );
        }
    );
  }
}


