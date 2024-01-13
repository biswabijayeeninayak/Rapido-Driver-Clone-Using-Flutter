import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/model/service_hour_model.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

class ServiceHourCard extends StatelessWidget {
  final ServiceHourModel serviceHourModel;
  const ServiceHourCard({Key? key, required this.serviceHourModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      builder: (riderController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
          child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withOpacity(.05),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(width: Dimensions.iconSizeMedium,
                    child: Image.asset(
                        riderController.hourActivityIndex == 0?
                        Images.activeHourIcon:
                        riderController.hourActivityIndex == 1?
                        Images.onDrivingHourIcon:
                        riderController.hourActivityIndex == 2?
                        Images.idleHourIcon:Images.offlineHourIcon

                    )),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(serviceHourModel.title))
              ],),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Text(serviceHourModel.createdAt),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Text('${riderController.hourActivityIndex == 0?
              'stayed'.tr:
              riderController.hourActivityIndex == 1?
                  'drove'.tr:
              riderController.hourActivityIndex == 2?
                  'idle'.tr:'offline'.tr
              } '
                  '${serviceHourModel.time} ${'min'.tr}',
                style: textRegular.copyWith(
                  color: riderController.hourActivityIndex == 0?
                  Colors.orange[500]:
                  riderController.hourActivityIndex == 1?
                  Theme.of(context).primaryColor:
                  riderController.hourActivityIndex == 2?
                  Theme.of(context).colorScheme.tertiaryContainer
                      :Theme.of(context).colorScheme.secondaryContainer
                ),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
            ],
          ),),
        );
      }
    );
  }
}
