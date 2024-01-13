import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/my_offer/controller/my_offer_controller.dart';
import 'package:ride_sharing_user_app/view/screens/my_offer/widget/level_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:ride_sharing_user_app/view/widgets/type_button_widget.dart';

class MyOfferScreen extends StatelessWidget {
  const MyOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyOfferController>(
        builder: (myOfferController) {
          return Column(children: [
            CustomAppBar(title: 'my_offer'.tr),
            Container(transform: Matrix4.translationValues(0, -25, 0),
              child: SizedBox(height: Get.find<LocalizationController>().isLtr? 45 : 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: myOfferController.myOfferTypeList.length,
                    itemBuilder: (context, index){
                      return TypeButtonWidget( index: index,
                        name: myOfferController.myOfferTypeList[index],
                        selectedIndex: myOfferController.myOfferTypeIndex,
                        onTap: ()=> myOfferController.setMyOfferTypeIndex(index),
                      );
                    }),
              ),
            ),

            if(myOfferController.myOfferTypeIndex == 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
              child: UserLevelWidget(),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault,),
            Expanded(
              child: Container(
                transform: Matrix4.translationValues(0, myOfferController.myOfferTypeIndex == 0? -20 : 0, 0),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSeven),
                    child: InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                        child: CustomImage(
                          height: 140,
                          width: Get.width,
                          image: 'https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg',
                        ),
                      ),
                    ),
                  );
                },itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            )
          ],);
        }
      ),
    );
  }
}
