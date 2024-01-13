import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/model/leaderboard_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class LeaderBoardCard extends StatelessWidget {
  final int index;
  final LeaderBoard leaderBoard;
  const LeaderBoardCard({Key? key, required this.index, required this.leaderBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Row(children: [
                Text('${index+1}.',style: textRegular.copyWith(color: Theme.of(context).textTheme.displayLarge!.color),),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
                ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: const CustomImage(width: 30,height: 30,image: '')),
              ],),

              Row(children: [
                Text('${PriceConverter.convertPrice(context, 2323)} /'  ,style: textMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color)),
                Text(' 7 ${'trips'.tr}', style: textRegular.copyWith(color: Theme.of(context).colorScheme.onPrimary),),

              ],)
            ],),
          ),
          Divider(color: Theme.of(context).primaryColor,thickness: .25,)
        ],
      ),
    );
  }
}
