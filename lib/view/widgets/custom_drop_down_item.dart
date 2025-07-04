
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class CustomDropDownItem extends StatelessWidget {
  final String? title;
  final Widget? widget;
  const CustomDropDownItem({Key? key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [

        title != null?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text(title!.tr, style: textRegular),
        ):const SizedBox(),

        Container(height: 30,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: .7, color: Theme.of(context).primaryColor.withOpacity(.25))
          ),
          alignment: Alignment.center,
          child: Container(transform: Matrix4.translationValues(0, -10, 0),
              child: Center(child: widget)),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall)
      ],),
    );
  }
}