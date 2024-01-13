import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/my_activity_model.dart';

class HourOfServiceCard extends StatelessWidget {
  final ScrollController scrollController;
  final int index;
  final MyActivityModel myActivityModel;

  const HourOfServiceCard({Key? key, required this.myActivityModel, required this.index, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      initState: (context){
        scrollController.animateTo(index* Get.width/3, duration: const Duration(seconds: 1), curve: Curves.easeIn);
      },
      builder: (rideController) {
        return Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: (){
              rideController.setHourActivityIndex(index);
              scrollController.animateTo(index* Get.width/3, duration: const Duration(seconds: 1), curve: Curves.easeIn);

            },
            child: Container(width: 150,
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: index == rideController.hourActivityIndex ? Theme.of(context).colorScheme.onSecondary: Theme.of(context).primaryColor),
                color: index == rideController.hourActivityIndex? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text('${myActivityModel.status.tr} ${'hour'.tr}',
                      textAlign: TextAlign.center,
                      style: textSemiBold.copyWith(
                          color : index == rideController.hourActivityIndex?
                      Colors.white:
                          Theme.of(context).hintColor.withOpacity(.65), fontSize: Dimensions.fontSizeLarge)),
                ),
              ],),
            ),
          ),
        );
      }
    );
  }
}