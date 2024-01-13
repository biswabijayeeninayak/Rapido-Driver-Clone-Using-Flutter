import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/convert_point_to_wallet_money.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/my_earn_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/point_gained_card.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drawer.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down_item.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';
import 'package:ride_sharing_user_app/view/widgets/type_button_widget.dart';


class WalletScreenMenu extends GetView<ProfileController> {
  const WalletScreenMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: const ProfileMenuScreen(),
        mainScreen: const WalletScreen(),
        borderRadius: 24.0,
        angle: -5.0,
        isRtl: !Get.find<LocalizationController>().isLtr,
        menuBackgroundColor: Theme.of(context).primaryColor,
        slideWidth: MediaQuery.of(context).size.width * 0.85,
        mainScreenScale: .4,
      ),
    );
  }
}




class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<WalletController>().getMyEarnList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<WalletController>(
        builder: (walletController) {
          return Column(children: [
            CustomAppBar(title: 'my_wallet'.tr, showBackButton: false, onTap: (){
              Get.find<ProfileController>().toggleDrawer();
            }),

            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              child: Container(transform: Matrix4.translationValues(0, -25, 0),
                child: SizedBox(height: Get.find<LocalizationController>().isLtr? 45 : 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: walletController.walletTypeList.length,
                      itemBuilder: (context, index){
                        return TypeButtonWidget(
                          cardWidth: 140,
                          index: index,name: walletController.walletTypeList[index],selectedIndex: walletController.walletTypeIndex,
                          onTap: ()=> walletController.setWalletTypeIndex(index),
                        );
                      }),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  CustomTitle(title: walletController.walletTypeIndex == 0?
                  'wallet_money'.tr :walletController.walletTypeIndex == 1?
                  'all_transaction'.tr:'account_point'.tr,
                    color: Theme.of(context).textTheme.displayLarge!.color,),
                  const WalletMoneyAmountWidget(),


                  SizedBox(height: walletController.walletTypeIndex == 2? Dimensions.paddingSizeDefault : 0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Row(children: [
                      Text(walletController.walletTypeIndex == 0?
                      'my_earn'.tr:
                      walletController.walletTypeIndex == 1?
                      walletController.selectedFilterTypeName.tr : 'point_gained_history'.tr,
                        style: textBold.copyWith(color: Theme.of(context).textTheme.displayLarge!.color, fontSize: Dimensions.fontSizeExtraLarge),),

                      const Spacer(),
                      walletController.walletTypeIndex != 2?
                      SizedBox(width: Dimensions.dropDownWidth,
                        child: CustomDropDownItem(
                          title: '',
                          widget: DropdownButtonFormField<String>(
                            value: walletController.selectedValue,
                            alignment: Alignment.center,
                            isExpanded: true,
                            decoration: const InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.zero,),
                            iconSize: Dimensions.iconSizeSmall, style: textRegular,
                            icon:  Icon(CupertinoIcons.chevron_down, color: Theme.of(context).primaryColor.withOpacity(.25),),
                            onChanged: (value) {
                              walletController.setFilterTypeName(value!);
                            },
                            items: walletController.selectedFilterType.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value.tr,
                                    style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
                              );

                            }).toList(),
                          ),
                        ),
                      ):const SizedBox.shrink(),

                    ],),
                  ),

                  SizedBox(height: walletController.walletTypeIndex == 2? Dimensions.paddingSizeDefault : 0),

                  (walletController.walletTypeIndex == 2 && !walletController.isConvert)?
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.orderStatusIconHeight),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: walletController.myEarnList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return PointGainedCard(myEarnModel: walletController.myEarnList[index]);
                        }),
                  ):(walletController.walletTypeIndex == 2 && walletController.isConvert)?
                  const ConvertPointToWalletMoney():
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.orderStatusIconHeight),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: walletController.myEarnList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return MyEarnCardWidget(myEarnModel: walletController.myEarnList[index]);
                        }),
                  )
                ],),
              ),
            ),



          ],);
        }
      ),
    );
  }
}
