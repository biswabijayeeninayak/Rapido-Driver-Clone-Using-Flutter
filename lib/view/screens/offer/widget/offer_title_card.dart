import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/reward_model.dart';

class OfferTitleCard extends StatelessWidget {
  final ScrollController scrollController;
  final RewardModel rewardModel;
  final int index;
  const OfferTitleCard({Key? key, required this.rewardModel, required this.index, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      initState: (context){
        scrollController.animateTo(index* Get.width/3, duration: const Duration(seconds: 1), curve: Curves.easeIn);
      },
      builder: (profileController) {
        return InkWell(
          highlightColor: Colors.transparent,
          onTap: (){
            profileController.setOfferTypeIndex(index);
            scrollController.animateTo(index* Get.width/3, duration: const Duration(seconds: 1), curve: Curves.easeIn);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSeven),
            child: Container(width: 170,
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: index == profileController.offerSelectedIndex? Theme.of(context).colorScheme.onSecondary: Theme.of(context).primaryColor),
                color: index == profileController.offerSelectedIndex?
                Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,

                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(rewardModel.title,maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: textRegular.copyWith(color:index == profileController.offerSelectedIndex?
                            Colors.white:
                        Theme.of(context).hintColor.withOpacity(.65), fontSize: Dimensions.fontSizeLarge))),

                  ],
                ),

              ],),
            ),
          ),
        );
      }
    );
  }
}