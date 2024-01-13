import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class RouteCalculationWidget extends StatelessWidget {
  const RouteCalculationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeDefault),
      child: GetBuilder<RiderMapController>(
        builder: (riderController) {
          return Column(
            children: [
              Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.085)

                      ),
                      child: Text('01:01:45',style: textBold.copyWith(color: Theme.of(context).primaryColor),),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Row(children: [
                      SizedBox(height: Dimensions.roadArrowHeight,
                          child: Image.asset(Images.roadLineArrow)),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child:  Text('2.23 km',style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                        ),
                        const Text('Cres road'),
                      ],)
                    ],),


                  ],),

                ),
                const SizedBox(width: Dimensions.paddingSizeExtraLarge),
                Stack(
                  children: [
                    Positioned(left: 0,right: 0,top: 0,bottom: 0,
                        child: CircularPercentIndicator(
                          radius: 30,
                          progressColor: Theme.of(context).colorScheme.onSecondary.withOpacity(.435),
                          percent: .9,
                        )),
                    Column(children: [

                      Padding(
                        padding:  const EdgeInsets.only(top: Dimensions.paddingSizeSignUp),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('10.5',style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
                            Text('km',style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Text('destination'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor),),



                    ],),
                  ],
                )
              ],),

              Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
                child: CustomButton(buttonText: riderController.tripPaused?  'resume_trip_from_here'.tr : 'pause_trip_for_a_moment'.tr,
                  transparent: true,
                  icon: riderController.tripPaused? Icons.play_arrow_rounded : Icons.pause,
                  borderWidth: .5,
                  showBorder: true,
                  textColor: riderController.tripPaused? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.75),
                  radius: Dimensions.paddingSizeSmall,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  onPressed: (){
                  riderController.tripStatusToggle();
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
