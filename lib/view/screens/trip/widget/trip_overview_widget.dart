import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/view/screens/trip/controller/trip_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/chart_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down_item.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_title.dart';

class TripOverviewWidget extends StatelessWidget {
  final TripController tripController;
  const TripOverviewWidget({Key? key, required this.tripController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(transform: Matrix4.translationValues(0, -20, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Row(children: [
            Text('trips_overview'.tr, style: textSemiBold.copyWith(color: Theme.of(context).textTheme.displayLarge!.color, fontSize: Dimensions.fontSizeExtraLarge),),

            const Spacer(),

            GetBuilder<WalletController>(
                builder: (walletController) {
                  return SizedBox(width: Dimensions.dropDownWidth,
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
                  );
                }
            ),

          ],),
        ),
      ),
      Container(transform: Matrix4.translationValues(0, -10, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text('success_rate'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.75)),),
            Text('74 %', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
          ],),
        ),
      ),

      const SizedBox(height: 220,
      child: ChartWidget(),),

      CustomTitle(title: 'reports'.tr,color: Theme.of(context).textTheme.displayLarge!.color,),

      const ReportsItemCard(title: 'total_trip',amount: 34),
      const ReportsItemCard(title: 'total_earn',amount: 3400,isTotal: true,),
      const ReportsItemCard(title: 'total_cancel_trip',amount: 9),
      const ReportsItemCard(title: 'penalty',amount: 12),
      const ReportsItemCard(title: 'total_review',amount: 30),
      const SizedBox(height: Dimensions.orderStatusIconHeight),



    ],);
  }
}


class ReportsItemCard extends StatelessWidget {
  final String? title;
  final double? amount;
  final bool isTotal;
  const ReportsItemCard({Key? key, this.title, this.amount, this.isTotal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.05),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Text(title!.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.displayLarge!.color),),

        isTotal?
        Text(PriceConverter.convertPrice(context, amount!),style: textMedium.copyWith(color: Theme.of(context).primaryColor),):
        Text(amount!.toString(),style: textMedium.copyWith(color: Theme.of(context).primaryColor),)

      ],),),
    );
  }
}
