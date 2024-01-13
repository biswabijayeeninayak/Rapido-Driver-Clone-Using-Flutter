import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/offer/offer_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/reward_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RewardCardWidget extends StatelessWidget {
  final int index;
  final RewardModel rewardModel;
  final bool fromOfferPage;
  const RewardCardWidget({Key? key, required this.rewardModel, required this.index, this.fromOfferPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentCompleted = (rewardModel.todayTargetFilUpAmount!/rewardModel.todayTargetAmount!);
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: (){
        Get.find<ProfileController>().setOfferTypeIndex(index);
        Get.to(()=> OfferScreen(index: index));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:fromOfferPage ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSeven),
        child: Container(width: fromOfferPage? Get.width : 170,
          padding: EdgeInsets.all(fromOfferPage? Dimensions.paddingSizeLarge: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            border: Border.all(width: .25, color: Theme.of(context).primaryColor),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(rewardModel.title,maxLines: 2,overflow: TextOverflow.ellipsis,
                          style: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.65), fontSize: Dimensions.fontSizeLarge))),

                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  fromOfferPage?
                  Text(rewardModel.amount.toString(), style: textSemiBold.copyWith(color: Theme.of(context).primaryColor ,fontSize: Dimensions.fontSizeExtraLarge)):
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rewardModel.amount.toString(), style: textSemiBold.copyWith(color: Theme.of(context).primaryColor ,fontSize: Dimensions.fontSizeExtraLarge)),
                      SizedBox(width: Dimensions.rewardImageSize,
                          child: Image.asset(rewardModel.image,))
                    ],
                  ),


                  if(fromOfferPage)
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  rewardModel.step?
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSeven),
                    child: SizedBox(height: 18,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: fromOfferPage?MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          Text('${rewardModel.filUpStep}/${rewardModel.targetStep}', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                          Container(transform: Matrix4.translationValues(0, 2, 0),
                            child: Stack(
                              children: [
                                SizedBox(height: 10,
                                  child: ListView.builder(
                                    itemCount: rewardModel.targetStep,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Container(width: 100/rewardModel.targetStep!,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).colorScheme.onTertiary
                                      ),),
                                    );
                                  }),
                                ),
                                SizedBox(height: 10,
                                  child: ListView.builder(
                                      itemCount: rewardModel.filUpStep,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context,index){
                                        return Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(width : 100/rewardModel.targetStep!,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Theme.of(context).primaryColor
                                            ),),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment:fromOfferPage?MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        Text('\$${rewardModel.todayTargetFilUpAmount}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                        const SizedBox(width: Dimensions.paddingSizeTiny),
                        SizedBox(height: 6,
                          child: LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            width: 98.0,
                            lineHeight: 6.0,
                            percent: percentCompleted,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Theme.of(context).colorScheme.onTertiary,
                            progressColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),



                ],),
              ),
              if(fromOfferPage)
                SizedBox(width: Dimensions.rewardImageSizeOfferPage,
                    child: Image.asset(rewardModel.image,))
            ],
          ),
        ),
      ),
    );
  }
}