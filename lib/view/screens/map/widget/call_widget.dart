import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(mainAxisSize: MainAxisSize.min,children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
            child: Text('call_to'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              color: Theme.of(context).hintColor.withOpacity(.125)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
            Text('Jane Copper'),
            Text('01213456789',style: textMedium),

          ],),),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                color: Theme.of(context).hintColor.withOpacity(.125)
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Mr. Anderson'),
                Text('01234567877',style: textMedium),

              ],),)
        ],),
      ),
    );
  }
}
