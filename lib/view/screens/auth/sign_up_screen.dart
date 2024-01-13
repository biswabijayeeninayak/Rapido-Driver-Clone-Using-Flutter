import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
// import 'package:ride_sharing_user_app/view/widgets/country_picker.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
  String selectedRole = '';
   bool _acceptTerms = false;
  @override
  void initState() {
    Get.find<AuthController>().phoneController.text = countryDialCode;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

return Scaffold(
  body: SafeArea(
    child: GetBuilder<AuthController>(builder: (authController) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.logo, width: 120,),
                      const SizedBox(height: Dimensions.paddingSizeSignUp),
                    ],
                  ),
                ),
    
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: Text(
                    'Sign Up'.tr,
                    style: textBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                ),
    
                Text(
                  'sign_up_message'.tr,
                  style: textRegular.copyWith(color: Theme.of(context).hintColor),
                  maxLines: 2,
                ),
    
                const SizedBox(height: Dimensions.paddingSizeLarge,),
    
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldTitle(title: 'Name'.tr,),
                          CustomTextField(
                            hintText: 'Enter your Name'.tr,
                            inputType: TextInputType.name,
                            prefixIcon: Images.person,
                            controller: authController.fNameController,
                            focusNode: authController.fNameNode,
                            nextFocus: authController.phoneNode,
                            inputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    
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
    
                TextFieldTitle(title: 'password'.tr,),
                CustomTextField(
                  hintText: 'Enter your Password'.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  isPassword: true,
                  controller: authController.passwordController,
                  focusNode: authController.passwordNode,
                  nextFocus: authController.emailNode,
                  inputAction: TextInputAction.next,
                ),
                TextFieldTitle(title: 'Email'.tr,),
                CustomTextField(
               
                  hintText: 'Enter your Email',
                  inputType: TextInputType.text,
                  prefixIcon: Images.email,
                  controller: authController.emailController,
                  focusNode: authController.emailNode,
                  inputAction: TextInputAction.done,
                ),
              
                TextFieldTitle(title: 'Select Role'.tr,),

             GestureDetector(
  onTap: () {
    _showRoleSelectionCard(context);
  },
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(
        width: 0.5,
        color: Theme.of(context).hintColor.withOpacity(0.5),
      ),
      color: Theme.of(context).cardColor,
    ),
    child: Row(
      children: [
        // Replace the following block with your prefix icon or CodePickerWidget
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 70, // Adjust the width as needed
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), // Same as the container's border radius
              bottomLeft: Radius.circular(20), // Same as the container's border radius
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Icon(
                Icons.select_all_sharp, // Replace with your icon or widget
                size: 30,
                color: Color(0xFF08a48c), // Replace with your desired color
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(selectedRole.isNotEmpty ? "${selectedRole}" : 'Select Role', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,fontSize: 17),),
        ),
  
      ],
    ),
  ),
             ),

    
                const SizedBox(height: Dimensions.paddingSizeDefault * 3,),
    
                CheckboxListTile(
                      title: Text(
                        'I accept the terms and conditions',
                        style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                      ),
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
    
                CustomButton(
                  buttonText: 'Register'.tr,
                  onPressed: () {
    
    
                        String fName = authController.fNameController.text;
                        String phone = authController.phoneController.text;
                        String password = authController.passwordController.text;
                        String email = authController.emailController.text;
                        String role = selectedRole; 
    
                        if(fName.isEmpty){
                          showCustomSnackBar('first_name_is_required'.tr);
                        }else if(phone.isEmpty){
                          showCustomSnackBar('phone_is_required'.tr);
                        }else if(phone.length<8){
                          showCustomSnackBar('phone_number_is_not_valid'.tr);
                        }else if(password.isEmpty){
                          showCustomSnackBar('password_is_required'.tr);
                        }else if(password.length<8){
                          showCustomSnackBar('minimum_password_length_is_8'.tr);
                        }else if(email.isEmpty){
                          showCustomSnackBar('confirm_password_is_required'.tr);
                        }else if(role.isEmpty){
                          showCustomSnackBar('confirm_password_is_required'.tr);
                        }else if (!_acceptTerms) {
                          showCustomSnackBar(
                              'Please accept the terms and conditions to register.');
                        }
                       else {
                          // Validate phone number
                          String digitsOnly =
                              phone.replaceAll(RegExp(r'[^0-9]'), '');
                          if (digitsOnly.length != 12) {
                            showCustomSnackBar(
                                'Please enter a valid 10-digit phone number.');
                            return;
                          }

                          Register(role, fName, email,phone, password);
    
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
  ),
    );
  }
// }


void _showRoleSelectionCard(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Choose Role',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Delivery Partner'),
              leading: Radio(
                value: 'Delivery Partner',
                groupValue: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Pilot'),
              leading: Radio(
                value: 'Pilot',
                groupValue: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}


Future<void> Register(String role, String userName, String email, String phone, String password) async {
    print(role);

    try {
      var url = Uri.parse('${Constant().url}dp_register');

      String phoneNumberWithoutCode =
          phone.startsWith('+91') ? phone.substring(3) : phone;

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "role": role,
          "first_name": userName,
          "email": email,
          "phone": phoneNumberWithoutCode,
          "password":password,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Get.to(() => const SignInScreen());
        // Get.to(SignInScreen());
        Get.back();
      } else {
        customSnackBar('Registration failed,Number already exist');
        print('Registration failed with status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error during registration: $error');
    }
  }

}