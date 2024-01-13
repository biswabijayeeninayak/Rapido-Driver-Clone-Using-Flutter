
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/pick_hour_stop_confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class NextTimePickWidget extends StatelessWidget {
  const NextTimePickWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderMapController>(
        builder: (riderMapController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              Center(
                child: Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'your_pick_time'.tr),
                      const TextSpan(text: ' '),
                      TextSpan(text :'activated'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                    ]
                )),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Padding(
                padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeSmall),
                child: Text('next_pack_time'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
              ),

              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(.06),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                ),
                child: Column(children: const [
                  NextTimeFrameItem(title: 'evening',timeFrame: '4.00 pm - 6.30 pm'),
                  NextTimeFrameItem(title: 'night',timeFrame: '6.30 pm - 11.30 pm'),

              ],),),

              CustomButton(buttonText: 'deactivate_pack_time'.tr, radius: Dimensions.paddingSizeSmall,
                textColor: Theme.of(context).colorScheme.error,borderColor: Theme.of(context).colorScheme.error,
                showBorder: true,borderWidth: .25,transparent: true,onPressed: (){
                showDialog(context: context, builder: (_)=> const PickOurStopConfirmationDialog());
                },)

            ]),
          );
        }
    );
  }
}

class NextTimeFrameItem extends StatelessWidget {
  final String title;
  final String timeFrame;
  const NextTimeFrameItem({Key? key, required this.title, required this.timeFrame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Row(children: [
           Icon(Icons.access_time, size: Dimensions.iconSizeMedium,color: Theme.of(context).primaryColor.withOpacity(.5),),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(title.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),),
        ],),

        Text(timeFrame, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.5)),)
      ],),
    );
  }
}

