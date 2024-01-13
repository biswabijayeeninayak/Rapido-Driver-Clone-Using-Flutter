import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/active_your_pick_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/calculating_sub_total_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/custom_icon_card.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_chat_call_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/customer_ride_request_card.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/end_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/next_pick_time_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/offline_mode_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/otp_verification_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/pin_location_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/stay_online_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/stay_online_with_narrow_zone.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/trip_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';


class RiderBottomSheet extends StatelessWidget {
  const RiderBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
      builder: (riderController) {
        return GetBuilder<RideController>(
          builder: (rideController) {
            return Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius : const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeDefault),
                          topRight : Radius.circular(Dimensions.paddingSizeDefault)),
                      boxShadow: [BoxShadow(color: Theme.of(context).hintColor, blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))]
                  ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child : Column(
                          children: [
                            Container(height: 5, width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(.25),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),

                              ),),

                            if(riderController.stayOnlineTypeIndex == 0)
                            const StayOnlineWidget(),
                            if(riderController.stayOnlineTypeIndex == 1)
                              riderController.activatedPack?
                            const NextTimePickWidget():
                            const ActiveYourPickWidget(),
                            if(riderController.stayOnlineTypeIndex == 2)
                            const CustomerRideRequestCardWidget(),
                            if(riderController.stayOnlineTypeIndex == 3)
                              const CustomerChatCallWidget(),
                            if(riderController.stayOnlineTypeIndex == 4)
                              const OtpVerificationWidget(),
                            if(riderController.stayOnlineTypeIndex == 5)
                              const TripDetailsWidget(),
                            if(riderController.stayOnlineTypeIndex == 6)
                              const EndTripWidget(),
                            if(riderController.stayOnlineTypeIndex == 7)
                              const CalculatingSubTotalWidget(),
                            if(riderController.stayOnlineTypeIndex == 8)
                              const OfflineModeWidget(),
                            if(riderController.stayOnlineTypeIndex == 9)
                              const PinLocationWidget(),
                            if(riderController.stayOnlineTypeIndex == 10)
                              const StayOnlineWithNarrowZoneWidget(),


                            Padding(
                              padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  CustomIconCard(index: 0,icon: Images.mIcon1,selectedIndex: riderController.stayOnlineTypeIndex,onTap: ()=> riderController.setStayOnlineTypeIndex(0)),
                                  CustomIconCard(index: 1,icon: Images.mIcon2,selectedIndex: riderController.stayOnlineTypeIndex, onTap: ()=> riderController.setStayOnlineTypeIndex(1)),
                                  CustomIconCard(index: 2,icon: Images.mIcon3,selectedIndex: riderController.stayOnlineTypeIndex,onTap: ()=> riderController.setStayOnlineTypeIndex(2)),
                                ],),
                            ),


                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                          ],
                        )
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
