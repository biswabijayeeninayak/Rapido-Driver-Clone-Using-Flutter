import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/bid_accepted_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class BiddingDialog extends StatefulWidget {
  final int index;
  const BiddingDialog({Key? key, required this.index}) : super(key: key);

  @override
  State<BiddingDialog> createState() => _BiddingDialogState();
}

class _BiddingDialogState extends State<BiddingDialog> {
  TextEditingController bidingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
      child: GetBuilder<RideController>(
        builder: (rideController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min,children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(),
                Text('start_your_bidding'.tr, style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                Stack(
                  children: [
                    SizedBox(width: 50,
                    child: CircularPercentIndicator(radius: 25,
                      percent: .75,
                      progressColor: Theme.of(context).primaryColor,
                      lineWidth: .7,
                      animation: true,
                    ),),
                    Positioned(left: 0,bottom: 0,right: 0,top: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('59', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                          Text('sec', style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),),
                        ],),
                      ),
                    )
                  ],
                )
              ],),
              CustomerInfoWidget(index: widget.index),
               Divider(thickness: 1,color: Theme.of(context).hintColor,),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text('your_bid'.tr),
                Text('\$250',style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
              ],),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(
                  children: [
                    SizedBox(width: Dimensions.iconSizeMedium, child: Image.asset(Images.biddingIcon)),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Text('\$250'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                  ],
                ),
                Text('customer_bid'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
              ],),


              if(rideController.isFinalBid)
              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text('your_bid'.tr),
                  Text('\$345',style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
                ],),

                const SizedBox(height: Dimensions.paddingSizeDefault),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Row(
                    children: [
                      SizedBox(width: Dimensions.iconSizeMedium, child: Image.asset(Images.biddingIcon)),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Text('\$250'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  Text('customer_bid'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
                ],),
              ]),


              if(rideController.isFinalBid)
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 40, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
                child: Row(children: [
                  Expanded(child: CustomButton(buttonText: 'dis_agree'.tr,
                  showBorder: true,
                  transparent: true,
                  borderColor: Theme.of(context).primaryColor,
                  radius: Dimensions.paddingSizeSmall,
                  onPressed: (){Get.back();
                  })),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(child: CustomButton(buttonText: 'agree'.tr,
                      radius: Dimensions.paddingSizeSmall,
                      onPressed: () async{
                    Get.find<RiderMapController>().setStayOnlineTypeIndex(3);
                    rideController.toggleFinalBid();
                        Get.back();
                    Get.dialog(const FindingRiderDialogue(), barrierDismissible: false);
                    await Future.delayed( const Duration(seconds: 3));
                        Get.back();

                  })),
                ],),
              ),

              if(!rideController.isFinalBid)
              const SizedBox(height: 100),
              if(!rideController.isFinalBid)
              Text('enter_your_bid'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor),),

              if(!rideController.isFinalBid)
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const SizedBox(),
                  SizedBox(height: 50,
                    child: IntrinsicWidth(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: bidingController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'enter_your_bid'.tr,
                          hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:  BorderSide(width: 0.0,
                                color: Theme.of(context).hintColor.withOpacity(0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:  BorderSide(width: 0.0,
                                color: Theme.of(context).hintColor.withOpacity(0)),
                          ),


                        ),

                      ),
                    ),
                  ),

                  GestureDetector(onTap: ()=> rideController.toggleFinalBid(),
                      child: SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.arrowRight,color: Theme.of(context).primaryColor)))


                ],),),
              )

            ],),
          );
        }
      ),
    );
  }
}
