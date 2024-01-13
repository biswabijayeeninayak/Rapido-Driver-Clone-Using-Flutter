import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';

class PinLocationWidget extends StatelessWidget {
  const PinLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
        builder: (riderMapController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(children: [

              GestureDetector(
                onTap: ()=> Get.find<RiderMapController>().setStayOnlineTypeIndex(10),
                child: SizedBox(width: Dimensions.iconSizeExtraLarge,
                    child: Image.asset(Images.showCampusIcon)),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('pin_location_or_select'.tr,
                      style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Text('your_destination'.tr, style: textMedium.copyWith()),

                ],
              ),



            ]),
          );
        }
    );
  }
}


