import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
class AcceptRideWidget extends StatelessWidget {
  const AcceptRideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
      builder: (riderController) {
        return Column(children: [
          Padding(
            padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Text('ride_request_details'.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          ),

          Row(children: [
            Container(width: 100,height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: ClipRRect(
                borderRadius : BorderRadius.circular(50),
                child: const CustomImage(
                  image: '',
                ),
              ),),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text('${riderController.distance.toStringAsFixed(2)}km ${'away_from_your_location'.tr}', style: textRegular.copyWith()),
            ],)
          ],),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(children: [
            Container(width: 30,height: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.125),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                child: Icon(Icons.my_location_rounded, color: Theme.of(context).primaryColor)),
            const SizedBox(width: Dimensions.paddingSizeSmall),



          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(children: [
            Container(width: 30,height: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.125),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                child: Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor)),
            const SizedBox(width: Dimensions.paddingSizeSmall),


          ]),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('34 km', style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text('distance'.tr, style: textRegular.copyWith()),
                ]),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('45 min', style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text('ETA', style: textRegular.copyWith()),
                ]),


              ]),
          ),

          Center(child: InkWell(
            onTap: (){


            },
            child: Text('ignore'.tr, style: textRegular.copyWith(color: Colors.redAccent)),
          )),
          const SizedBox(height: Dimensions.paddingSizeDefault),

        ]);
      }
    );
  }
}
