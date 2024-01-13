import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';

class StayOnlineWidget extends StatelessWidget {
  const StayOnlineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
      builder: (riderMapController) {
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(children: [

            SizedBox(width: Dimensions.iconSizeOnline,
                child: Image.asset(Images.onlineIcon)),
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraSmall),
              child: Text('stay_online'.tr, style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
            ),
            Text('customer_are_surrounding_you'.tr, style: textMedium.copyWith()),



          ]),
        );
      }
    );
  }
}


