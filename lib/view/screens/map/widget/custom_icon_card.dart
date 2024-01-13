import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';

class CustomIconCard extends StatelessWidget {
  final String icon;
  final int index;
  final int selectedIndex;
  final Function()? onTap;
  const CustomIconCard({Key? key, required this.icon, required this.index, required this.selectedIndex, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Container(decoration: BoxDecoration(
            border: Border.all(width: .25, color: Theme.of(context).primaryColor.withOpacity(.75)),
            borderRadius: BorderRadius.circular(100),
            color: index == selectedIndex ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimaryContainer
        ),child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSize),
          child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(icon, color: index == selectedIndex ? Colors.white: Theme.of(context).primaryColor)),
        ),),
      ),
    );
  }
}