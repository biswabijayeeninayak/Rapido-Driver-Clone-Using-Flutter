import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class CloseDestinationNarrowWidget extends StatelessWidget {
  const CloseDestinationNarrowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
      child: GetBuilder<RiderMapController>(
          builder: (riderMapController) {
            return Padding(
              padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                Padding(padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: SizedBox(width: Dimensions.iconSizeDialog,
                      child: Image.asset(Images.closeDes)),
                ),

                Text.rich(TextSpan(children: [
                  TextSpan(text: 'do_you_want_to'.tr, style: textMedium.copyWith(),),
                  const TextSpan(text: ' '),
                  TextSpan(text: 'close'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).colorScheme.error),),
                ])

                ),

                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraLarge),
                  child: Center(
                    child:  Text( 'your_destination_ride'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                  ),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 100,
                      child: CustomButton(
                        radius: Dimensions.paddingSizeDefault,
                        buttonText: 'confirm'.tr,
                        onPressed: () {
                          riderMapController.setStayOnlineTypeIndex(0);
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    SizedBox(width: 100,
                      child: CustomButton(
                        backgroundColor: Theme.of(context).hintColor.withOpacity(.35),
                        textColor: Theme.of(context).colorScheme.secondaryContainer,
                        radius: Dimensions.paddingSizeDefault,
                        buttonText: 'deny'.tr,
                        onPressed: () {Get.back();
                        },
                      ),
                    ),
                  ],
                )

              ]),
            );
          }
      ),
    );
  }
}
