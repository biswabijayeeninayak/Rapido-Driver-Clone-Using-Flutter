

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/offer/widget/offer_title_card.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';

class OfferListView extends StatefulWidget {
  const OfferListView({Key? key}) : super(key: key);

  @override
  State<OfferListView> createState() => _OfferListViewState();
}

class _OfferListViewState extends State<OfferListView> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container( transform: Matrix4.translationValues(0, -30, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GetBuilder<ProfileController>(
            builder: (profileController) {
              return SizedBox(height: 70,
                child: ListView.builder(
                  controller: scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: profileController.rewardList.length,
                    itemBuilder: (context, index){
                      return OfferTitleCard(rewardModel : profileController.rewardList[index], index: index,scrollController: scrollController,);
                    }),
              );
            }
        ),
      ),
    );
  }
}
