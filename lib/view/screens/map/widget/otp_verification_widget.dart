import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/bid_accepted_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';



class OtpVerificationWidget extends StatelessWidget {
  const OtpVerificationWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (rideController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraSmall),
              child: Text('enter_pin_to_start_trip'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
            ),
            Text('ask_customer_to_check_the_phone'.tr, style: textRegular.copyWith()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,),
                      child: PinCodeTextField(
                        length: 4,
                        appContext: context,
                        obscureText: false,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 63,
                          fieldWidth: 55,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: Theme.of(context).primaryColor,
                          selectedFillColor: Theme.of(context).primaryColor.withOpacity(.25),
                          inactiveFillColor: Theme.of(context).disabledColor.withOpacity(.125),
                          inactiveColor: Theme.of(context).disabledColor.withOpacity(.125),
                          activeColor: Theme.of(context).primaryColor.withOpacity(.123),
                          activeFillColor: Theme.of(context).primaryColor.withOpacity(.125),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: (text){

                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.find<RiderMapController>().setStayOnlineTypeIndex(5);
                      Get.dialog(const FindingRiderDialogue(isStartedTrip: true,), barrierDismissible: false);
                      await Future.delayed( const Duration(seconds: 3));
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(Images.arrowRight),),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
