import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/sub_total_header.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/payment_item_info.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          CustomAppBar(title: 'trip_details'.tr),
          SubTotalHeaderTitle(title: 'your_trip_is_completed'.tr,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              SummeryItem(title: '1.24hr',subTitle: 'time'.tr,),
              SummeryItem(title: '8km',subTitle: 'distance'.tr,),
              SummeryItem(title: 'on',subTitle: 'route'.tr,),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('your_success_rate_for_this_trip'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.75)),),
                Text(' ${'98%'}', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            child: Text('trip_details'.tr),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: RouteWidget(index: 0),
          ),

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Container(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor, width: .5),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Text('payment_details'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
                ),
                PaymentItemInfo(icon: Images.waitingPrice,title: 'waiting_price'.tr,amount: 234,),
                PaymentItemInfo(icon: Images.idleHourIcon,title: 'idle_price'.tr,amount: 3435,),
                PaymentItemInfo(icon: Images.farePrice,title: 'fare_price'.tr,amount: 234,),
                PaymentItemInfo(title: 'sub_total'.tr,amount: 234, isSubTotal: true,),
              ],),),
          )

        ],),
      ),
    );
  }
}

class SummeryItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const SummeryItem({Key? key, required this.title, required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.check_circle,size: Dimensions.iconSizeSmall, color: Colors.green),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
        child: Text(title, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
      ),
      Text(subTitle, style: textRegular.copyWith(color: Theme.of(context).hintColor)),

    ],);
  }
}


