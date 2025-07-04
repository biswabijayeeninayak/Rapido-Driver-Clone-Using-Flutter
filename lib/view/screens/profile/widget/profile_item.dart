import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isStatus;
  final bool isLevel;
  const ProfileItem({Key? key, required this.title, required this.value,  this.isStatus = false,  this.isLevel = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr, style: textMedium.copyWith(),),
          isLevel?
          Container(decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.10),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
          ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: Dimensions.paddingSizeExtraSmall),
              child: Text('Level 3', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
            ),):
          isStatus?
          FlutterSwitch(
            width: 37.0,
            height: 19.0,
            valueFontSize: 14.0,
            toggleSize: 15.0,
            value: true,
            borderRadius: 30.0,
            padding: 2,
            activeColor: Theme.of(context).primaryColor,
            showOnOff: false,
            activeTextFontWeight: FontWeight.w700,
            toggleColor: Colors.white,
            onToggle: (val) {

            },
          ):
          Text(value, style: textRegular.copyWith(color: Theme.of(context).hintColor),),
        ],
      ),
    );
  }
}