import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:ride_sharing_user_app/view/widgets/open_map.dart';

class DriverHeaderInfoWidget extends StatelessWidget {
  const DriverHeaderInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 60, Dimensions.paddingSizeDefault,0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Theme.of(context).primaryColor)
          ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const CustomImage(width: 50,height: 50,image: '',)),
          ),

          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 1,spreadRadius: 1, offset: const Offset(0,1))]
            ),
            child: ExpandableNotifier(
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Expandable(
                    collapsed: ExpandableButton(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeLarge, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeLarge,0),
                            child: Column(mainAxisSize: MainAxisSize.min,children: [
                              Text('${'\$ 765.09'} / ${'3'} ${'trip'.tr}'),
                              Text('todays_earn'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                              Icon(Icons.arrow_drop_down_outlined,color: Theme.of(context).hintColor,)
                            ],),
                          ),
                        ],
                      ),
                    ),
                    expanded: Column(
                        children: [
                          Container(
                              color: Theme.of(context).primaryColor.withOpacity(.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeLarge, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeLarge,0),
                                child: Column(mainAxisSize: MainAxisSize.min,children: [
                                  Text('${'\$ 765.09'} / ${'3'} ${'trip'.tr}'),
                                  Text('todays_earn'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                                  Icon(Icons.arrow_drop_down_outlined,color: Theme.of(context).hintColor,)
                                ],),
                              ),
                          ),
                         SizedBox(height: 70,width: 220,
                           child: ListView.builder(itemCount: 3,
                               padding: EdgeInsets.zero,
                               physics: const NeverScrollableScrollPhysics(),
                               itemBuilder: (context, index){
                             return Padding(
                               padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                               child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                 CircleAvatar(radius: 2,backgroundColor: Theme.of(context).hintColor),
                                 const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                 const Text('Trip 1.34hr / 12.21 pm - \$ 222'),
                               ],),
                             );
                           }),
                         ),



                          ExpandableButton(
                            child: Container(
                                padding:  const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                child:  Icon(Icons.arrow_drop_up_outlined,
                                  size: Dimensions.iconSizeLarge,
                                  color : Theme.of(context).primaryColor.withOpacity(.75),)),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            )


          ),
          InkWell(
            onTap: (){
              MapUtils.openMap(23.8376555,90.36982);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                  boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 1,spreadRadius: 1, offset: const Offset(0,1))]
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: SizedBox(width: Dimensions.iconSizeLarge,child: Image.asset(Images.searchIcon)),
              ),),
          )
        ],),
    );
  }
}
