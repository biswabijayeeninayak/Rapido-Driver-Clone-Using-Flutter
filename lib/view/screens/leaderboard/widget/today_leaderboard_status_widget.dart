import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class TodayLeaderBoardStatusWidget extends StatelessWidget {
  const TodayLeaderBoardStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Container(
        transform: Matrix4.translationValues(0, -30, 0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            border: Border.all(width: .5,
                color: Theme.of(context).primaryColor)

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraLarge),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:  [
            Text('your_today'.tr, style: textBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge),),

            Row(
              children: [
                Text('${'\$750'} / '.tr, style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                Text('4 ${'trip'.tr} '.tr, style: textMedium.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeLarge),),
              ],
            ),

          ],),
        ),
      ),
    );
  }
}
