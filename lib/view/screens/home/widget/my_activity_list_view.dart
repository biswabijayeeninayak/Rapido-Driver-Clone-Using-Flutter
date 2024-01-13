

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/activity_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';

class MyActivityListView extends StatelessWidget {
  const MyActivityListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(title: 'my_activity'),
        GetBuilder<RideController>(
            builder: (rideController) {
              return SizedBox(height: Get.find<LocalizationController>().isLtr? 80 : 85,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: rideController.activityList.length,
                    itemBuilder: (context, index){
                      return MyActivityCard(myActivityModel : rideController.activityList[index], index:  index);
                    }),
              );
            }
        ),
      ],
    );
  }
}
