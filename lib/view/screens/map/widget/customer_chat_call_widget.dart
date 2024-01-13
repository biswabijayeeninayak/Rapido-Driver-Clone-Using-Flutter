
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/chat/chat_screen.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/call_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/pick_hour_stop_confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class CustomerChatCallWidget extends StatelessWidget {
  const CustomerChatCallWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
        builder: (riderMapController) {

          return GetBuilder<RideController>(
            builder: (rideController) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('pickup_timer'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.25),
                      borderRadius: BorderRadius.circular(100),
                    ),child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                         Text('00:01:49', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.onDrivingHourIcon),)
                      ],),
                    ),),
                  ],),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),


                  Center(
                    child: Column(children: [
                      Text('your_pick_up_time_is_counting'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                      Text('please_reach_the_pickup_point'.tr,style: textMedium.copyWith()),
                    ],)

                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),


                  Center(
                    child: Container(width: 250,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        border: Border.all(width: .75, color: Theme.of(context).primaryColor)
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                        InkWell(
                          onTap : ()=> Get.to(()=> const ChatScreen()),
                          // onTap: ()=> Get.find<RiderMapController>().setStayOnlineTypeIndex(4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                            child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(Images.customerMessage)),
                          ),
                        ),
                        Container(width: 1,height: 25,color: Theme.of(context).primaryColor),
                        GestureDetector(
                          onTap: ()=> showDialog(context: context, builder: (_)=> const CallWidget()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                            child: SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.customerCall)),
                          ),
                        ),

                      ],),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                    child: CustomerInfoWidget(index: 0),
                  ),

                  CustomButton(buttonText: 'cancel'.tr, radius: Dimensions.paddingSizeSmall,
                    textColor: Theme.of(context).colorScheme.error,borderColor: Theme.of(context).colorScheme.error,
                    showBorder: true,borderWidth: .25,transparent: true,onPressed: (){
                      showDialog(context: context, builder: (_)=> const PickOurStopConfirmationDialog());
                    },)



                ]),
              );
            }
          );
        }
    );
  }
}

class NextTimeFrameItem extends StatelessWidget {
  final String title;
  final String timeFrame;
  const NextTimeFrameItem({Key? key, required this.title, required this.timeFrame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Row(children: [
          Icon(Icons.access_time, size: Dimensions.iconSizeMedium,color: Theme.of(context).primaryColor.withOpacity(.5),),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(title.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),),
        ],),

        Text(timeFrame, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),)
      ],),
    );
  }
}

