import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';

class StayOnlineWithNarrowZoneWidget extends StatelessWidget {
  const StayOnlineWithNarrowZoneWidget({Key? key}) : super(key: key);

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
                child: Text('stay_online_searching_ride'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                child: Text('you_will_get_only'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
              ),
              Text('Banani, sector 12 destination ride', style: textMedium.copyWith()),



            ]),
          );
        }
    );
  }
}


