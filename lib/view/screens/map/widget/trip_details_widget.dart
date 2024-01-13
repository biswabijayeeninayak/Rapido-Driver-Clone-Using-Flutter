import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/route_calculation_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/payment_item_info.dart';


class TripDetailsWidget extends StatelessWidget {
  const TripDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        builder: (riderController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:  [

              const RouteCalculationWidget(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text('trip_details'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
              ),
              const Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: RouteWidget(index:0),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor, width: .25),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                    PaymentItemInfo(icon: Images.farePrice, title: 'fare_price'.tr,amount: 234,isFromTripDetails: true),
                    PaymentItemInfo(icon: Images.paymentTypeIcon, title: 'payment'.tr,amount: 234, paymentType: 'Cash',),
                  ],),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                child: Text('note'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
              ),
              Text('customer_note'.tr,style: textRegular.copyWith(color: Theme.of(context).hintColor),),

              const SizedBox(height: Dimensions.paddingSizeSmall),

              const CustomerInfoWidget(index: 0,fromTripDetails: true,),

              CustomButton(buttonText: 'stop_ride'.tr, radius: Dimensions.paddingSizeSmall,
                textColor: Theme.of(context).colorScheme.error,borderColor: Theme.of(context).colorScheme.error,
                showBorder: true,borderWidth: .25,transparent: true,onPressed: (){
                Get.find<RiderMapController>().setStayOnlineTypeIndex(6);
                  //showDialog(context: context, builder: (_)=> const PickOurStopConfirmationDialog());
                },)

            ],),
          );
        }
    );
  }
}
