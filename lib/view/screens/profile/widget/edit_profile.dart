import 'dart:io';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/signup_body.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';



class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen>  with TickerProviderStateMixin {
  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
  @override
  void initState() {
    Get.find<AuthController>().phoneController.text = countryDialCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'edit_profile'.tr,regularAppbar : true),
      body: GetBuilder<AuthController>(builder: (authController){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(
                  onTap: (){
                    authController.pickImage(false, true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Container(
                      height: 80,
                      width: Get.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1
                          )
                      ),
                      child: Center(
                        child: Stack(alignment: AlignmentDirectional.center,
                          clipBehavior: Clip.none,
                          children: [
                            authController.pickedProfileFile==null?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const CustomImage(
                                image: '',
                                height: 76,
                                width: 76,
                                placeholder: Images.personPlaceholder,
                              ),
                            )
                                :CircleAvatar(radius: 40, backgroundImage:FileImage(File(authController.pickedProfileFile!.path))),

                            Positioned(
                                right: 5,
                                bottom: -3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(Icons.camera_enhance_rounded, color: Colors.white,size: 13,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      TextFieldTitle(title: 'first_name'.tr,),
                      CustomTextField(
                        hintText: 'first_name'.tr,
                        inputType: TextInputType.name,
                        prefixIcon: Images.person,
                        controller: authController.fNameController,
                        focusNode: authController.fNameNode,
                        nextFocus: authController.lNameNode,
                        inputAction: TextInputAction.next,
                      )],
                    ),
                  ),

                  const SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(
                    child:  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      TextFieldTitle(title: 'last_name'.tr,),
                      CustomTextField(
                        hintText: 'last_name'.tr,
                        inputType: TextInputType.name,
                        prefixIcon: Images.person,
                        controller: authController.lNameController,
                        focusNode: authController.lNameNode,
                        nextFocus: authController.phoneNode,
                        inputAction: TextInputAction.next,
                      )],
                    ),
                  )
                ]),

                TextFieldTitle(title: 'phone'.tr,),
                CustomTextField(
                  hintText: 'phone',
                  inputType: TextInputType.number,
                  countryDialCode: "+91",
                  controller: authController.phoneController,
                  focusNode: authController.phoneNode,
                  nextFocus: authController.passwordNode,
                  inputAction: TextInputAction.next,
                  onCountryChanged: (CountryCode countryCode){
                    countryDialCode = countryCode.dialCode!;
                    authController.phoneController.text = countryDialCode;
                  },
                ),

                TextFieldTitle(title: 'email'.tr,),
                CustomTextField(
                  hintText: 'email'.tr,
                  inputType: TextInputType.emailAddress,
                  prefixIcon: Images.email,
                  controller: authController.emailController,
                  focusNode: authController.emailNode,
                  nextFocus: authController.addressNode,
                  inputAction: TextInputAction.next,

                ),

                TextFieldTitle(title: 'address'.tr,),
                CustomTextField(
                  hintText: 'address'.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.location,
                  controller: authController.addressController,
                  focusNode: authController.addressNode,
                  nextFocus: authController.identityNumberNode,
                  inputAction: TextInputAction.next,
                ),




                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(children: [
                    Expanded(
                      child: CustomButton(
                        transparent: true,
                        borderColor: Theme.of(context).colorScheme.error,
                        showBorder: true,
                        buttonText: 'cancel'.tr,
                        onPressed: (){
                          Get.back();
                        },
                        radius: 5,
                        borderWidth: .5,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: CustomButton(
                        buttonText: 'save'.tr,
                        onPressed: (){
                          String email = authController.emailController.text;
                          String address = authController.addressController.text;
                          String identityNumber = authController.identityNumberController.text;
                            SignUpBody signUpBody = SignUpBody(
                              email: email,
                              address: address,
                              identityNumber: identityNumber,

                            );
                            // authController.registration(signUpBody);
                            debugPrint(signUpBody.email);
                            showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
                            Get.back();

                        },
                        radius: 5,
                      ),
                    ),
                  ],),
                ),



                const SizedBox(height: Dimensions.paddingSizeDefault,),
              ],
            ),
          ),
        );
      }),
    );
  }
}
