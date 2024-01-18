
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/view/screens/trip/controller/trip_controller.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/trip_overview_widget.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/trips_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drawer.dart';
import 'package:ride_sharing_user_app/view/widgets/type_button_widget.dart';


class ProfileTripHistoryScreen extends StatelessWidget {
  const ProfileTripHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TripController>(
        initState: (context)=> Get.find<TripController>().getTripList(),
        builder: (tripController) {
          return Column(
            children: [
              CustomAppBar(title: 'trip_history'.tr,showBackButton: true,
              //     onTap: (){
              //   Get.find<ProfileController>().toggleDrawer();
              // },
              ),
              Container(transform: Matrix4.translationValues(0, -25, 0),
                child: SizedBox(height: Get.find<LocalizationController>().isLtr? 45 : 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: tripController.activityTypeList.length,
                      itemBuilder: (context, index){
                        return TypeButtonWidget( index: index,
                          name: tripController.activityTypeList[index],
                          selectedIndex: tripController.activityTypeIndex,
                          onTap: ()=> tripController.setActivityTypeIndex(index),
                        );
                      }),
                ),
              ),


              tripController.activityTypeIndex == 0?
              TripsWidget(tripController: tripController):
               TripOverviewWidget(tripController: tripController)



            ],
          );
        }
      ),


    );
  }
}
