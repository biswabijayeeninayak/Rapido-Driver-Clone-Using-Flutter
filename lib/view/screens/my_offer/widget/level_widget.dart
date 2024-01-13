import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class UserLevelWidget extends StatelessWidget {

  const UserLevelWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('your_level'.tr,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.displayLarge!.color),),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(0.4),width:0.5),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                child: Row(children: [
                  Text("${'level'.tr} ${3}"),
                  const SizedBox(width: 5,),
               ],
                ),
              )
            ],
          ),
        ),
       Padding(
        padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child:  Divider(color: Theme.of(context).primaryColor.withOpacity(0.3),height: 0.5,),
      ),

      const SizedBox(height: Dimensions.paddingSizeSmall,),

      Text.rich(TextSpan(
        style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
          children:  [
            TextSpan(text: 'you_are_level'.tr,),

          ],
        ),
      ),

      const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'total'.tr,
              style: DefaultTextStyle.of(context).style,
              children:  <TextSpan>[
                TextSpan(text: ' ${756} ', style: textRegular.copyWith(color: Theme.of(context).primaryColor)),
                TextSpan(text: 'point'.tr.toLowerCase()),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Icon(Icons.circle,size: 3,),
          ),

          RichText(
            text: TextSpan(
              text: 'earn_more'.tr,
              style: DefaultTextStyle.of(context).style,
              children:  <TextSpan>[
                const TextSpan(text: ' ${144} '),
                TextSpan(text: 'point'.tr),
              ],
            ),
          ),

        ],
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault,),
      LinearPercentIndicator(
        percent: .50,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        progressColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.zero,
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault,),


      ],
    );
  }
}
