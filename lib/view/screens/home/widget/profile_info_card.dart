import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ProfileStatusCard extends StatelessWidget {
  const ProfileStatusCard({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(Dimensions.paddingSize),
          child: Row(children:  [
            SizedBox(child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              child: const CustomImage(
                width: 40,height: 40,
                image: 'https://firebasestorage.googleapis.com/v0/b/flas-chat-f6e00.appspot.com/o/driver.png?alt=media&token=6a48be63-2eb3-4cae-8c43-8964e9e7ac47',

              ),
            ),),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('Leslie Alexander'.tr, style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.10),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Text('Level 3', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                  ),)
              ],),
            ),


            GetBuilder<RiderMapController>(
              builder: (riderMapController) {
                return FlutterSwitch(
                  width: 95.0,
                  height: 30.0,
                  valueFontSize: 14.0,
                  toggleSize: 28.0,
                  value: riderMapController.profileOnline,
                  borderRadius: 30.0,
                  padding: 0,
                  activeColor: Theme.of(context).primaryColor.withOpacity(.1),
                  toggleBorder: Border.all(width: 5, color: Colors.white.withOpacity(.75)),
                  activeText: 'status'.tr,
                  inactiveText: 'status'.tr,
                  activeTextColor: Theme.of(context).primaryColor,
                  showOnOff: true,
                  activeTextFontWeight: FontWeight.w700,
                  toggleColor: Colors.red,
                  onToggle: (val) {
                    riderMapController.toggleProfileStatus();
                    if(val == false){
                      riderMapController.setStayOnlineTypeIndex(8);
                    }


                  },
                );
              }
            )
          ],),
        ),
      ),
    );
  }
}
