import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/bid_accepted_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/bidding_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class CustomerRideRequestCardWidget extends StatelessWidget {
  const CustomerRideRequestCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<RideController>(
      builder: (rideController) {
        return SizedBox(
          height: 470,
          child: AppinioSwiper(
            cards: listOfRequest(),
          ),
        );
      }
    );
  }
}

List<Widget> listOfRequest() {
  List<Widget> request = [];
  for(int index=0; index < Get.find<RideController>().rideRequestList.length; index++) {
    request.add(
      GetBuilder<RideController>(
        builder: (riderController) {
          return Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
                color: Theme.of(Get.context!).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                border: Border.all(color: Theme.of(Get.context!).primaryColor,width: .35),
                boxShadow:[BoxShadow(color: Theme.of(Get.context!).primaryColor.withOpacity(.1), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0))]
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(width: Dimensions.iconSizeSmall,child: Image.asset(Images.leftArrow)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Text('swipe_left_to_reject'.tr, style: textRegular.copyWith(color: Theme.of(Get.context!).primaryColor),)
                ],),
              ),

              RouteWidget(index:index),


              CustomerInfoWidget(index: index),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(children: [
                  Icon(Icons.arrow_forward_outlined, color: Theme.of(Get.context!).primaryColor,size: Dimensions.iconSizeMedium),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  Text('11.34 Min ${'pickup_time'.tr}', style: textRegular.copyWith(color: Theme.of(Get.context!).primaryColor),),
                ],),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Row(children: [
                  Expanded(child: CustomButton(buttonText: 'bid'.tr,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: true,
                    radius: Dimensions.paddingSizeSmall,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    onPressed: (){
                    showDialog(context: Get.context!, builder: (_)=> BiddingDialog(index: index,));
                    },
                  )),
                  const SizedBox(width : Dimensions.paddingSizeLarge),
                  Expanded(child: CustomButton(buttonText: 'accept'.tr,
                    radius: Dimensions.paddingSizeSmall,
                    onPressed: () async{
                      Get.find<RiderMapController>().setStayOnlineTypeIndex(3);
                      riderController.toggleFinalBid();
                      Get.dialog(const FindingRiderDialogue(), barrierDismissible: false);
                      await Future.delayed( const Duration(seconds: 5));
                      Get.back();
                      await Future.delayed( const Duration(seconds: 5));
                      Get.find<RiderMapController>().setStayOnlineTypeIndex(4);
                    },
                  )),
                  ],),
              ),


            ],),);
        }
      )
    );
  }
  return request;
}