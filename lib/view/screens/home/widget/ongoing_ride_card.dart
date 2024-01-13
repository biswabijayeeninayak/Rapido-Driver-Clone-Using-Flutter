
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/custom_arrow_icon.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/custom_menu_driving_status.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down_item.dart';

class OngoingRideCard extends StatelessWidget {
  const OngoingRideCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        builder: (rideController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Container(
              transform: Matrix4.translationValues(0, -15, 0),
              decoration: BoxDecoration(
                border: Border.all(width: .25, color: Theme.of(context).primaryColor),
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),

              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Row(children: [
                    Column(children: [
                      Text('18th', style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                      const Text('Dec, 2022', style: textRegular),
                    ],),

                    const Spacer(),
                    SizedBox(width: Dimensions.dropDownWidth,
                      child: CustomDropDownItem(
                        title: '',
                        widget: DropdownButtonFormField<String>(
                          value: 'ongoing',
                          alignment: Alignment.center,
                          isExpanded: true,
                          decoration: const InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.zero,),
                          iconSize: Dimensions.iconSizeSmall, style: textRegular,
                          icon:  Icon(CupertinoIcons.chevron_down, color: Theme.of(context).primaryColor.withOpacity(.25),),
                          onChanged: (value) {
                          },
                          items: <String>['ongoing', 'last_trip'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.tr,
                                  style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  ],),
                ),

                Container(transform: Matrix4.translationValues(0, -35, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                      CustomArrowIcon(
                        onTap: (){
                          if(rideController.orderStatusSelectedIndex != 0){
                            rideController.setOrderStatusTypeIndex(rideController.orderStatusSelectedIndex-1);
                          }

                        },
                        color: rideController.orderStatusSelectedIndex == 0 ?
                        Theme.of(context).hintColor.withOpacity(.35):
                        Theme.of(context).primaryColor.withOpacity(.25),
                          icon: CupertinoIcons.left_chevron,
                        iconColor: rideController.orderStatusSelectedIndex == 0 ?
                        Theme.of(context).hintColor.withOpacity(.7):Theme.of(context).primaryColor
                      ),
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 10.0,
                        percent: rideController.orderStatusSelectedIndex == 0
                            ? 0.70 : rideController.orderStatusSelectedIndex == 1
                            ?0.90: rideController.orderStatusSelectedIndex == 2
                            ? 0.70 : 0.5,
                        circularStrokeCap: CircularStrokeCap.round,
                        center:  Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("estimated".tr,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall),
                              child: Text(rideController.orderStatusSelectedIndex == 0
                                  ? "12:34 min":
                              rideController.orderStatusSelectedIndex == 1
                                  ? '8.34 km':
                              rideController.orderStatusSelectedIndex == 2
                                  ?'\$ 240':'2',
                                style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                            ),
                            Text(rideController.orderStatusSelectedIndex == 0
                                ?"driving".tr:
                            rideController.orderStatusSelectedIndex == 1?
                            "derived".tr:
                            rideController.orderStatusSelectedIndex == 2?
                            "for_this_trip".tr:
                            "to_destination".tr,

                              style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                          ],
                        ),
                        progressColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).hintColor.withOpacity(.18),
                      ),
                      CustomArrowIcon(
                        onTap: (){
                          if(rideController.orderStatusSelectedIndex != 3){
                            rideController.setOrderStatusTypeIndex(rideController.orderStatusSelectedIndex+1);
                          }

                        },
                        color : rideController.orderStatusSelectedIndex != 3 ?
                        Theme.of(context).primaryColor.withOpacity(.25):
                        Theme.of(context).hintColor.withOpacity(.35),
                        icon: CupertinoIcons.right_chevron,
                        iconColor: rideController.orderStatusSelectedIndex != 3 ?
                        Theme.of(context).primaryColor:Theme.of(context).hintColor.withOpacity(.7)),
                    ],),
                  ),
                ),

                Container(transform: Matrix4.translationValues(0, -35, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top:Dimensions.paddingSizeSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Text(rideController.orderStatusSelectedIndex == 0
                          ? '${'ongoing_trip_time'.tr}:':'${'ongoing_trip_distance'.tr}:',
                          style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Text(rideController.orderStatusSelectedIndex == 0?
                            '45:34':'12.45', style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
                      ),
                      Text(rideController.orderStatusSelectedIndex == 0?'min'.tr:'km'.tr,
                          style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5))),
                    ],),
                  ),
                ),

                Container(transform: Matrix4.translationValues(0, -10, 0),
                  child: SizedBox(height: Dimensions.orderStatusIconHeight,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      CustomMenuDrivingStatus( index: 0, selectedIndex: rideController.orderStatusSelectedIndex,icon: Images.drivingIcon),
                      CustomMenuDrivingStatus( index: 1, selectedIndex: rideController.orderStatusSelectedIndex,icon: Images.drivedIcon),
                      CustomMenuDrivingStatus( index: 2, selectedIndex: rideController.orderStatusSelectedIndex,icon: Images.paymentIcon),
                      CustomMenuDrivingStatus( index: 3, selectedIndex: rideController.orderStatusSelectedIndex,icon: Images.destinationIcon),
                    ],),
                  ),
                )



              ],),),
          );
        }
    );
  }
}
