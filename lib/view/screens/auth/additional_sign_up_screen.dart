import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/helper/email_checker.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/signup_body.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class AdditionalSignUpScreen extends StatelessWidget {
  const AdditionalSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(Images.logo, width: 120,)),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,Dimensions.paddingSizeSignUp,0,Dimensions.paddingSizeSmall),
                    child: Text('sign_up_as_driver'.tr,
                      style: textBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge,),
                    ),
                  ),
                  Text('additional_sign_up_message'.tr,style: textRegular.copyWith(color: Theme.of(context).hintColor),maxLines: 2,),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),

                  GestureDetector(
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

                  TextFieldTitle(title: 'identification_number'.tr,),
                   CustomTextField(
                    hintText: 'Ex: 12345',
                    inputType: TextInputType.text,
                    prefixIcon: Images.identity,
                    controller: authController.identityNumberController,
                     focusNode: authController.identityNumberNode,
                     inputAction: TextInputAction.done,
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 46),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      GestureDetector(
                        onTap: ()=> authController.pickImage(false, false),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Align(alignment: Alignment.center, child:
                          DottedBorder(
                            color: Theme.of(context).hintColor,
                            dashPattern: const [3,4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(Dimensions.paddingSizeSmall),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                child: authController.pickedIdentityImageFront != null ?  Image.file(File(authController.pickedIdentityImageFront!.path),
                                  width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
                                ) :SizedBox(height: Dimensions.identityImageHeight,
                                  width: Dimensions.identityImageWidth,
                                  child: Image.asset(Images.cameraPlaceholder,width: 50),
                                ),
                              ),
                              Positioned(
                                bottom: 0, right: 0, top: 0, left: 0,
                                child: InkWell(
                                  // onTap: () => authProvider.pickImage(true,false, false),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                    ),

                                  ),
                                ),
                              ),
                            ]),
                          )),
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),

                      GestureDetector(
                        onTap: ()=> authController.pickImage(true, false),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Align(alignment: Alignment.center, child:
                          DottedBorder(
                            color: Theme.of(context).hintColor,
                            dashPattern: const [3,4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(Dimensions.paddingSizeSmall),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                child: authController.pickedIdentityImageBack != null ?  Image.file(File(authController.pickedIdentityImageBack!.path),
                                  width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
                                ) :SizedBox(height: Dimensions.identityImageHeight,
                                  width: Dimensions.identityImageWidth,
                                  child: Image.asset(Images.cameraPlaceholder,width: 50,),
                                ),
                              ),
                              Positioned(
                                bottom: 0, right: 0, top: 0, left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  ),

                                ),
                              ),
                            ]),
                          )),
                        ),
                      ),
                    ],),
                  ),


                  CustomButton(
                    buttonText: 'send'.tr,
                    onPressed: (){
                      String email = authController.emailController.text;
                      String address = authController.addressController.text;
                      String identityNumber = authController.identityNumberController.text;


                      if(authController.pickedProfileFile == null){
                        showCustomSnackBar('profile_image_is_required'.tr);
                      }else if(email.isEmpty){
                        showCustomSnackBar('email_is_required'.tr);
                      }else if (EmailChecker.isNotValid(email)) {
                        showCustomSnackBar('enter_valid_email_address'.tr);
                      }else if(address.isEmpty){
                        showCustomSnackBar('address_is_required'.tr);
                      }else if(identityNumber.isEmpty){
                        showCustomSnackBar('identity_number_is_required'.tr);
                      }
                      else if(authController.pickedIdentityImageFront == null){
                        showCustomSnackBar('identity_image_front_is_required'.tr);
                      }
                      else if(authController.pickedIdentityImageBack == null){
                        showCustomSnackBar('identity_image_back_is_required'.tr);
                      }
                      else{
                        SignUpBody signUpBody = SignUpBody(
                            email: email,
                            address: address,
                            identityNumber: identityNumber,

                        );
                        // authController.registration(signUpBody);
                        debugPrint(signUpBody.email);
                        Get.off(()=> const DashboardScreen());
                      }
                    },
                    radius: 50,
                  ),

                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
