import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class OtpLoginScreen extends StatelessWidget {
  const OtpLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
    debugPrint(countryDialCode);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.logo, width: 150,),
                      const SizedBox(height: Dimensions.paddingSizeLarge,),

                      Image.asset(Images.otpScreenLogo, width: 150,),
                      const SizedBox(height: Dimensions.paddingSizeLarge,),
                      Row()
                    ],
                  ),

                  Row(children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text('otp_login'.tr,
                        style: textBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge,),
                      ),
                      Text('enter_your_phone_number'.tr,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      const SizedBox(height: Dimensions.paddingSizeLarge,)
                    ]
                    )],
                  ),

                  CustomTextField(
                    hintText: 'phone',
                    inputType: TextInputType.number,
                    countryDialCode: "+880",
                    onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  CustomButton(
                    buttonText: 'send_otp'.tr,
                    onPressed: (){

                    },
                    radius: 50,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider(),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: 8),
                        child: Text('or'.tr ,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      ),
                      const Expanded(child: Divider(),),
                    ],
                  ),
                  CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    buttonText: 'log_in'.tr,
                    onPressed: (){

                    },
                    radius: 50,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${'do_not_have_an_account'.tr} ',
                        style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),

                      TextButton(
                        onPressed: (){
                          // authController.signInPhoneController.clear();
                          // authController.signInPasswordController.clear();
                          Get.to(()=>const SignUpScreen());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50,30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                        ),
                        child: Text('sign_up'.tr, style: textRegular.copyWith(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: Dimensions.fontSizeSmall,
                        )),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("terms_and_condition".tr, style: textMedium.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: Dimensions.fontSizeSmall,
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
