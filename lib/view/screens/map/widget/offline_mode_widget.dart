import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';

class OfflineModeWidget extends StatelessWidget {
  const OfflineModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
        builder: (riderMapController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [

              SizedBox(width: Dimensions.iconSizeExtraLarge,
                  child: Image.asset(Images.offlineMode)),
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraSmall),
                child: Text('you_are_in_offline_mode'.tr, style: textBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),
              ),
              Text('stay_online_mode_to_get_more_ride'.tr, style: textMedium.copyWith()),



            ]),
          );
        }
    );
  }
}


