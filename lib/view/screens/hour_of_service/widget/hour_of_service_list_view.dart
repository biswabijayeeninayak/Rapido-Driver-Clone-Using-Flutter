import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/widget/hour_of_service_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

class HourOfServiceListView extends StatefulWidget {
  const HourOfServiceListView({Key? key}) : super(key: key);

  @override
  State<HourOfServiceListView> createState() => _HourOfServiceListViewState();
}

class _HourOfServiceListViewState extends State<HourOfServiceListView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Container( transform: Matrix4.translationValues(0, -30, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GetBuilder<RideController>(
            builder: (rideController) {
              return SizedBox(height: 70,
                child: ListView.builder(
                  controller: scrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: rideController.activityList.length,
                    itemBuilder: (context, index){
                      return HourOfServiceCard(myActivityModel : rideController.activityList[index], index: index, scrollController: scrollController);
                    }),
              );
            }
        ),
      ),
    );
  }
}
