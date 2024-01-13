import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/hour_of_service_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/my_activity_model.dart';

class MyActivityCard extends StatelessWidget {
  final int index;
  final MyActivityModel myActivityModel;

  const MyActivityCard({Key? key, required this.myActivityModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: (){
          Get.to(()=> HourOfService(index: index));
          Get.find<RideController>().setHourActivityIndex(index);
        },
        child: Container(width: 150,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment : CrossAxisAlignment.start,children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(myActivityModel.status.tr, style: textSemiBold.copyWith(color: myActivityModel.color, fontSize: Dimensions.fontSizeLarge)),
                SizedBox(width: Dimensions.iconSizeMedium,
                    child: Image.asset(myActivityModel.icon,color: myActivityModel.color))
              ],
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text(myActivityModel.timeFrame, style: textSemiBold.copyWith(color: myActivityModel.color, fontSize: Dimensions.fontSizeExtraLarge)),
          ],),
        ),
      ),
    );
  }
}