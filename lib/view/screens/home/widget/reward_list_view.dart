

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/reward_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';

class RewardListView extends StatefulWidget {
  const RewardListView({Key? key}) : super(key: key);

  @override
  State<RewardListView> createState() => _RewardListViewState();
}

class _RewardListViewState extends State<RewardListView> {

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(title: 'hexa_reward'),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GetBuilder<ProfileController>(
              builder: (profileController) {
                return SizedBox(height: 150,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: profileController.rewardList.length,
                      itemBuilder: (context, index){
                        return RewardCardWidget(rewardModel : profileController.rewardList[index], index: index,);
                      }),
                );
              }
          ),
        ),
      ],
    );
  }
}
