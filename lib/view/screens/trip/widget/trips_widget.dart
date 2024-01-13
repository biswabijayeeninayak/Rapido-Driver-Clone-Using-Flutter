import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/trip/controller/trip_controller.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/trip_card.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down_item.dart';
class TripsWidget extends StatelessWidget {
  final TripController tripController;
  const TripsWidget({Key? key, required this.tripController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Row(children: [
              Text('your_trip'.tr, style: textSemiBold.copyWith(color: Theme.of(context).textTheme.displayLarge!.color, fontSize: Dimensions.fontSizeExtraLarge),),

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

          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.orderStatusIconHeight),
            child: ListView.builder(
                itemCount: tripController.tripList.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return TripCard(tripModel: tripController.tripList[index]);
                }),
          )
        ],),
      ),
    );
  }
}
