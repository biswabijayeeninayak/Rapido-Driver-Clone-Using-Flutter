import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/bank_info_view.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';

class WithdrawAmountScreen extends StatefulWidget {
  const WithdrawAmountScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawAmountScreen> createState() => _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState extends State<WithdrawAmountScreen> {
  final List<int> _suggestedAmount = [1000,2000,3000,4000,5000, 10000,15000, 20000];
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          CustomAppBar(title: 'my_wallet'.tr, showBackButton: true),
          Container(transform: Matrix4.translationValues(0, -30, 0),
              child: const WalletMoneyAmountWidget(isWithDraw: true)),





          Container(transform: Matrix4.translationValues(0, -30, 0),
              child: CustomTitle(title: 'your_bank_account'.tr, color: Theme.of(context).textTheme.displayLarge!.color,)),

          Container(transform: Matrix4.translationValues(0, -25, 0),
            child: InkWell(
              onTap: ()=>Get.to(const BankInfoView()),
              child: GetBuilder<ProfileController>(
                  builder: (profileController) {

                    String accountNumber = 'BANK1234567876543';
                    String firstPart = '';
                    String lastPart = '';
                    firstPart = accountNumber.substring(0, 5);
                    lastPart = accountNumber.substring(accountNumber.length-3, accountNumber.length-1);
                    String acNumber =  '$firstPart****************$lastPart';



                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.08), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0))],
                          ),
                          padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Row(children: [
                            SizedBox(width: 30,child: Image.asset(Images.bank)),
                            const SizedBox(width: Dimensions.paddingSizeDefault,),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                const Text('MIT Bank'),
                                Text('AC $acNumber',style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                              ],),
                            ),
                             SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.editIcon))
                          ],)),
                    );
                  }
              ),
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width,

            padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text('withdraw_amount'.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$ ', style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).primaryColor)),
                  IntrinsicWidth(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: amountController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'enter_amount'.tr,
                        hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(width: 0.5,
                              color: Theme.of(context).hintColor.withOpacity(0.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(width: 0.5,
                              color: Theme.of(context).hintColor.withOpacity(0.0)),
                        ),


                      ),

                    ),
                  ),
                ],
              ),
              Divider(color: Theme.of(context).primaryColor.withOpacity(.25)),




              Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
                child: SizedBox(height: 30,
                  child: ListView.builder(itemCount: _suggestedAmount.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (amountContext, index){
                        return InkWell(
                          onTap: (){
                            amountController.text = _suggestedAmount[index].toString();
                          },
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall),
                            child: Container(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5): Theme.of(context).primaryColor.withOpacity(.75))),
                              child: Center(child: Text(_suggestedAmount[index].toString(),
                                style: textRegular.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5): Theme.of(context).primaryColor),)),),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text('remark'.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: noteController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'remark_hint'.tr,
                    hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:  BorderSide(width: 0.5,
                          color: Theme.of(context).primaryColor.withOpacity(0.25)),
                    ),


                  ),

                ),
              ),

            ],),),
        ],),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(height: 50,
          child: CustomButton(buttonText: 'send_withdraw_request'.tr,
          onPressed: (){
            Get.back();
            showCustomSnackBar('withdraw_successfully'.tr, isError: false);
          },),),
      ),
    );
  }
}
