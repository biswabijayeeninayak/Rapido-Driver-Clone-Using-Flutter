import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ProfileLevelWidget extends StatelessWidget {
  const ProfileLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 100,
          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
      child: Row(children:  [
        SizedBox(child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          child: const CustomImage(
            width: 40,height: 40,
            image: '',

          ),
        ),),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text('Leslie Alexander'.tr, style: textBold.copyWith(color: Colors.white,
                fontSize: Dimensions.fontSizeLarge),),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Container(decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.10),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text('Level 3', style: textRegular.copyWith(color: Colors.white),),
              ),)
          ],),
        ),
        GestureDetector(
          onTap: ()=> Get.find<ProfileController>().toggleDrawer(),
            child: const SizedBox(child: Icon(CupertinoIcons.clear, color: Colors.white),))


      ],),
    );
  }
}
