import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class SetDestinationScreen extends StatefulWidget {
  const SetDestinationScreen({Key? key}) : super(key: key);

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'search_location'.tr,regularAppbar: true),

      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
            child: Container(decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)

            ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  child: SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.customerRouteIcon,color: Theme.of(context).colorScheme.onSecondary.withOpacity(.75),)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Container(height: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                      ),
                      child:
                    TextFormField(
                      controller: inputController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                        hintText: 'Uttara',

                        suffixIcon: Icon(Icons.place_outlined, color: Theme.of(context).cardColor),
                        hintStyle: textRegular.copyWith(color: Theme.of(context).cardColor.withOpacity(.85)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(width: 0.5,
                              color: Theme.of(context).hintColor.withOpacity(0.5)),
                        ),


                      ),

                    ),),
                  ),
                ),
              ],),
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraLarge, 0, Dimensions.paddingSizeExtraLarge,Dimensions.paddingSizeDefault),
                  child: Text('done'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                      color: Theme.of(context).colorScheme.onSecondary.withOpacity(.75)),),
                )
            ],),),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
            child: Container(decoration: BoxDecoration(
                border:Border.all(color:  Theme.of(context).primaryColor,width: 1),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)

            ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Text('suggestions'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: ListView.builder(
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 6,
                    itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeTiny),
                            decoration: BoxDecoration(
                                color: Theme.of(context).hintColor.withOpacity(.08),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                            ), child: Icon(Icons.place_outlined, color: Theme.of(context).primaryColor.withOpacity(.5),)),
                        const SizedBox(width: Dimensions.paddingSizeSmall,),

                        const Text('Uttara, Sector 12'),
                      ],
                    ),
                  );
                }),
              ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Text('set_from_map'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                ),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.find<RiderMapController>().setStayOnlineTypeIndex(9);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                    child: Row(children: [
                      Container(padding: const EdgeInsets.all(Dimensions.paddingSizeTiny),
                        decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withOpacity(.08),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                        ),
                        child: SizedBox(width: Dimensions.iconSizeMedium,
                            child: Image.asset(Images.setFromMap)),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Text('choose_from_map'.tr, style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),)
                    ],),
                  ),
                )


            ],),),
          )
        ],),
      ),
    );
  }
}
