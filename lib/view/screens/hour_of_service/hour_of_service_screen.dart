import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/widget/hour_of_service_list_view.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/widget/service_hour_card.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/widget/service_type_and_hour_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_calender.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';




class HourOfService extends StatefulWidget {
  final int index;
  const HourOfService({Key? key, required this.index}) : super(key: key);
  @override
  State<HourOfService> createState() => _HourOfServiceState();
}

class _HourOfServiceState extends State<HourOfService> {



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<RideController>(
          builder: (rideController) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: 'hour_of_service'.tr, showBackButton: true),
                const HourOfServiceListView(),


                Container(transform: Matrix4.translationValues(0, -20, 0),
                    child: CustomTitle(title: '${rideController.activityName} ${'hour'.tr}',isFiler: true,
                      onTap: (){
                      showDialog(context: context, builder: (_)=> CustomCalender(
                        onChanged: (value){
                          Get.back();
                        },
                      ));

                      },
                    )),

                const ServiceHourAndStatusWidget(),

                ListView.builder(
                  itemCount: rideController.serviceHourList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                    return  ServiceHourCard(serviceHourModel: rideController.serviceHourList[index]);

                })


              ],
            );
          }
        ),
      ),
    );
  }
}





