import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/withdraw_amount_screen.dart';

class WalletMoneyAmountWidget extends StatelessWidget {
  final bool isWithDraw;
  const WalletMoneyAmountWidget({Key? key,  this.isWithDraw = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WalletController>(
      builder: (walletController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
          child: InkWell(
            onTap: (){
              if(walletController.walletTypeIndex == 2){
                walletController.toggleConvertCard(true);
              }else if(walletController.walletTypeIndex == 0){
                Get.to(()=> const WithdrawAmountScreen());
              }
            },
            child: DottedBorder(
              dashPattern: const [1,1],
              borderType: BorderType.RRect,
              color :  Theme.of(context).primaryColor,
              radius: const Radius.circular(Dimensions.paddingSizeDefault),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                child: Container(
                  decoration: BoxDecoration(
                    color: isWithDraw?Theme.of(context).colorScheme.errorContainer : null,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      Text( isWithDraw? 'withdrawable'.tr : walletController.walletTypeIndex == 0?
                      'USD':walletController.walletTypeIndex == 1?
                        walletController.selectedFilterTypeName.tr : 'point'.tr,
                        style: textBold.copyWith(color: Theme.of(context).primaryColor.withOpacity(.75), fontSize: Dimensions.fontSizeLarge),),
                      Row(
                        children: [
                          Text(PriceConverter.convertPrice(context, 67), style: textBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Theme.of(context).primaryColor)),
                          const SizedBox(width: Dimensions.paddingSizeDefault),
                          walletController.walletTypeIndex == 1 ? const SizedBox():
                           Icon(Icons.arrow_forward_ios,size: Dimensions.iconSizeMedium,
                             color: Theme.of(context).primaryColor,)
                        ],
                      )
                    ],),
                  ),),
              ),
            ),
          ),
        );
      }
    );
  }
}
