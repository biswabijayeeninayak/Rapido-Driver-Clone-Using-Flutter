import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/controller/leader_board_controller.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/widget/leader_board_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/widget/today_leaderboard_status_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {


  @override
  void initState() {
    Get.find<LeaderBoardController>().getLeaderBoardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LeaderBoardController>(
        builder: (leaderboardController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomAppBar(title: 'leader_board'.tr, showBackButton: true,),

            const TodayLeaderBoardStatusWidget(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,children: [
                      LeaderboardStageItem(color: Theme.of(context).colorScheme.primaryContainer,index: 2, name: 'Monalisa',tripCount: 09),
                      LeaderboardStageItem(color: Theme.of(context).primaryColor,index: 1, name: 'Mbappe',tripCount: 10),
                      LeaderboardStageItem(color: Theme.of(context).colorScheme.onErrorContainer,index: 3, name: 'Henry',tripCount: 07),
                    ],),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraLarge, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
                    child: Text('on_the_serial'.tr, style: textSemiBold,),
                  ),
                  ListView.builder(
                    itemBuilder: (context,index){
                      return  LeaderBoardCard(index: index,leaderBoard: leaderboardController.leaderBoardList[index]);
                    },
                    itemCount: leaderboardController.leaderBoardList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                  ),
                ],),
              ),
            )




          ],);
        }
      ),
    );
  }
}


class LeaderboardStageItem extends StatelessWidget {
  final Color color;
  final int index;
  final String name;
  final int tripCount;
  final bool isFirst;
  final bool isSecond;
  const LeaderboardStageItem({Key? key,
    required this.color,
    required this.index,
    required this.name,
    required this.tripCount,
     this.isFirst = false,
    this.isSecond = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Text(tripCount.toString().padLeft(2, '0'),
            style: textBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
                color: index ==3? Theme.of(context).colorScheme.tertiaryContainer: color),),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeSmall),
            child: Text('trips'.tr,style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: index ==3? Theme.of(context).colorScheme.tertiaryContainer: color),),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
                child: const CustomImage(image: '',width: 50,height: 50,)),
          ),

          Container(width: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSeven),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,
                  vertical: index == 1? Dimensions.paddingSizeDefault :Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 1, spreadRadius: 1, offset: const Offset(1,3))]
                    ),
                    width: index == 1? 40 : index == 3? 25 : 30, height:  index == 1? 40 : index == 3? 25 : 30,
                    child: Center(child: Text(index.toString(),
                      style: textBold.copyWith(
                        fontSize: index == 1? Dimensions.fontSizeExtraLarge:index == 3? 10 : Dimensions.fontSizeDefault,
                          color:  index == 3?
                          Theme.of(context).colorScheme.secondaryContainer : color),)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: index == 1? Dimensions.paddingSizeDefault :index == 3? 0: Dimensions.paddingSizeExtraSmall),
                    child: Text(name.toString(), style: textSemiBold.copyWith(color: index == 3? Theme.of(context).colorScheme.tertiaryContainer : Colors.white),),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
