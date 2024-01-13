import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/payment_received_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class EndTripWidget extends StatelessWidget {
  const EndTripWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (rideController) {
        return Column(children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeDefault),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(.15)

                  ),
                  child: Text('00:00:00',style: textBold.copyWith(color: Theme.of(context).primaryColor),),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    child:  Text('0 km',style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  ),
                  const Text('Bidadari Park Drive Singapore- 1 Wallich St Singapore'),

                ],),

              ),
              const SizedBox(width: Dimensions.paddingSizeExtraLarge),
              Column(children: [
                Container(
                  width: 60,height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.onSecondary.withOpacity(.35), width: 5),
                  borderRadius: BorderRadius.circular(100),

                ),
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('0',style: textSemiBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                        Text('km',style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                      ],
                    ),
                  ),),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Text('destination'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor),),



              ],)
            ],),
          ),
          Center(child: SizedBox(width: Dimensions.iconSizeDoubleExtraLarge,child: Image.asset(Images.reachedFlag))),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
             child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'end_this_trip_at'.tr,style: textMedium),
                 const TextSpan(text: ' '),
                  TextSpan(text: 'your_destination'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
          ),
           ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
            child: SizedBox(width: 250,
              child: Row(children: [
                Expanded(child: CustomButton(buttonText: 'continue'.tr,
                    showBorder: true,
                    transparent: true,
                    borderColor: Theme.of(context).primaryColor,
                    radius: Dimensions.paddingSizeSmall,
                    onPressed: (){Get.back();
                    })),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(child: CustomButton(buttonText: 'end'.tr,
                    radius: Dimensions.paddingSizeSmall,
                    onPressed: () async{
                      Get.find<RiderMapController>().setStayOnlineTypeIndex(7);
                      await Future.delayed( const Duration(seconds: 5));
                      Get.to(()=> const PaymentReceivedScreen());
                    })),
              ],),
            ),
          ),


        ],);
      }
    );
  }
}
