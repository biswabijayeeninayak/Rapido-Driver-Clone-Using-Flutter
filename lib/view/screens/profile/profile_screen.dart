import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/edit_profile.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_item.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_type_button_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';






class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Column(
            children: [
              CustomAppBar(title: 'profile'.tr, showBackButton: true,
              onTap: (){
                Get.find<ProfileController>().toggleDrawer();
              },),

              Container(transform: Matrix4.translationValues(0, -25, 0),
                child: SizedBox(height: Get.find<LocalizationController>().isLtr? 45 : 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: profileController.profileType.length,
                      itemBuilder: (context, index){
                        return ProfileTypeButtonWidget(profileTypeName : profileController.profileType[index], index: index);
                      }),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,0),
                child: Column(children:  [
                  SizedBox(child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    child: const CustomImage(
                      width: 80,height: 80,
                      image: 'https://firebasestorage.googleapis.com/v0/b/flas-chat-f6e00.appspot.com/o/driver.png?alt=media&token=6a48be63-2eb3-4cae-8c43-8964e9e7ac47',

                    ),
                  ),),
                  const SizedBox(height : Dimensions.paddingSizeDefault),
                  InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: ()=> Get.to(()=> const ProfileEditScreen()),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Leslie Alexander'.tr, style: textBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        if(profileController.profileTypeIndex == 0)
                        SizedBox(width: Dimensions.iconSizeMedium,
                            child: Image.asset(Images.editIcon)),
                        const SizedBox(width: Dimensions.paddingSizeSmall),


                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${'your_ratting'.tr} : 5 '),
                      const Icon(Icons.star_rounded, color: Colors.orange,size: Dimensions.iconSizeSmall,)
                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),


                  profileController.profileTypeIndex == 0?
                  Column(children: const [
                    ProfileItem(title: 'status',value: '',isStatus: true,),
                    ProfileItem(title: 'my_level',value: '',isLevel: true,),
                    ProfileItem(title: 'my_area',value: 'Dhanmondi',),
                    ProfileItem(title: 'contact',value: '0173674828',),
                    ProfileItem(title: 'mail_address',value: 'leslie@gmail.com',),
                    ProfileItem(title: 'my_address',value: '150/6 kolabagan Dhanmondi 32',),
                  ],):
                  Column(children: const [
                    ProfileItem(title: 'vehicle',value: 'Car'),
                    ProfileItem(title: 'vehicle_brand',value: 'Toyota'),
                    ProfileItem(title: 'vehicle_model',value: 'Corolla - E140',),
                    ProfileItem(title: 'vin',value: '3246276426',),
                    ProfileItem(title: 'number_plate',value: 'DH- 723487',),

                  ],)
                ],),
              )


            ],
          );
        }
      ),
    );
  }
}



