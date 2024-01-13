import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class PickOurStopConfirmationDialog extends StatelessWidget {
  const PickOurStopConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: GetBuilder<RiderMapController>(
          builder: (riderMapController) {
            return Padding(
              padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                Padding(padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: SizedBox(width: Dimensions.iconSizeDialog,
                      child: Image.asset(Images.pickOffConfirm)),
                ),

                Text.rich(TextSpan(children: [
                  TextSpan(text: 'you_can_get_more'.tr, style: textRegular.copyWith(),),
                  const TextSpan(text: ' '),
                  TextSpan(text: 'paid_ride_in_pick_time'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),),
                ])

                ),

                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeOverLarge),
                  child: Center(
                    child: Text.rich(TextSpan(children: [
                      WidgetSpan(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        Text( 'do_you_want_to'.tr, style: textSemiBold.copyWith()),
                        const SizedBox(width: 5),
                        Text('turn_off'.tr, style: textSemiBold.copyWith(color: Theme.of(context).colorScheme.error),),
                      ],)),
                      const TextSpan(text: '\n'),
                      WidgetSpan(child: Center(child: Text('pick_time_for_now'.tr, textAlign: TextAlign.center,
                          style: textSemiBold.copyWith(color: Theme.of(context).primaryColor))))

                    ])

                    ),
                  ),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 100,
                      child: CustomButton(
                        radius: Dimensions.paddingSizeDefault,
                        buttonText: 'confirm'.tr,
                        onPressed: () {
                        riderMapController.toggleActivatedPack();
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
