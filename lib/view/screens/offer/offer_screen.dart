import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/reward_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/offer/widget/offer_list_view.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';




class OfferScreen extends StatefulWidget {
  final int index;
  const OfferScreen({Key? key, required this.index}) : super(key: key);
  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'my_offer'.tr, showBackButton: true),
            const OfferListView(),

            Container(transform: Matrix4.translationValues(0, -10, 0),
              child: GetBuilder<ProfileController>(
                  builder: (profileController) {
                    return RewardCardWidget(rewardModel : profileController.rewardList[profileController.offerSelectedIndex],
                        index: profileController.offerSelectedIndex, fromOfferPage: true);
                  }
                  )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
              child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(.0525),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('other_details'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor)),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Column(children: [
                    OtherDetailsItem(title: 'total_ride_limit'.tr, value: 5),
                    OtherDetailsItem(title: 'total_earning_money_limit'.tr, amount: 1000),
                    OtherDetailsItem(title: 'total_cancellation_rate_limit'.tr, value: 5, isPercent: true,),
                    OtherDetailsItem(title: 'total_review_limit'.tr, value: 5),
                  ],),
                )
              ],),),
            ),

            GetBuilder<ProfileController>(
              builder: (profileController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.0525),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('other_term'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor)),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: ListView.builder(
                            itemCount: profileController.termList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                              child: Row(
                                children: [
                                  CircleAvatar(radius: 3,backgroundColor: Theme.of(context).textTheme.bodyLarge!.color,),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Expanded(child: Text(profileController.termList[index], style: textMedium.copyWith(),)),
                                ],
                              ),
                            );
                          })),

                      ],),),
                );
              }
            )



          ],
        ),
      ),
    );
  }
}

class OtherDetailsItem extends StatelessWidget {
  final String title;
  final int? value;
  final double? amount;
  final bool isPercent;
  const OtherDetailsItem({Key? key, required this.title,  this.value,  this.amount,  this.isPercent = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(title),
          if(value != null)
        Text(isPercent? '${value.toString()}%': value.toString()),
          if(amount != null)
            Text(PriceConverter.convertPrice(context, amount!)),
      ],),
    );
  }
}



