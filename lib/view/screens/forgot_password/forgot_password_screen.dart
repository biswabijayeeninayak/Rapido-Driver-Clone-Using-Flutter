import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/verification_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();
  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;

  @override
  void initState() {
    phoneController.text = countryDialCode;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
    return Scaffold(
      appBar: CustomAppBar(title: 'forget_password'.tr,showBackButton: true, regularAppbar: true,),
      body: GetBuilder<AuthController>(builder: (authController){
        debugPrint(countryDialCode);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.orderStatusIconHeight),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Images.logo, width: 150,),
                    const SizedBox(height: Dimensions.paddingSizeLarge,),

                    Image.asset(Images.forgotPasswordLogo, width: 150,),
                    const SizedBox(height: Dimensions.paddingSizeLarge,),
                    Row()
                  ],
                ),

                Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Text('forgot_password'.tr,
                      style: textBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge,),
                    ),
                    Text('enter_your_verified_phone_number'.tr,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                    const SizedBox(height: Dimensions.paddingSizeLarge,)
                  ]
                  )],
                ),

                CustomTextField(
                  controller: phoneController,
                  hintText: 'phone',
                  inputType: TextInputType.number,
                  countryDialCode: "+91",
                  onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                CustomButton(
                  buttonText: 'send_otp'.tr,
                  onPressed: (){

                    String phoneNumber = phoneController.text;
                    sendForgotPasswordOTP(phoneNumber);
                    // Get.to(()=> const VerificationScreen());
                  },
                  radius: 50,
                ),

              ],
            ),
          ),
        );
      }),
    );
  }





  Future<void> sendForgotPasswordOTP(String phoneNumber) async {
  var headers = {
    'Content-Type': 'application/json',
  };
  
  var request = http.Request('POST', Uri.parse('http://kods.tech/munsride/api/get-forgot-password-otp'));
  request.body = json.encode({
    "phone": phoneNumber,
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.to(()=> const VerificationScreen());
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print('Error: $e');
  }
}



}
