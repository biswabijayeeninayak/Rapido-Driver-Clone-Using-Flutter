import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/documents_dashboard.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:ride_sharing_user_app/view/screens/html/html_viewer_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
  @override
  void initState() {
    if (Get.find<AuthController>().getUserNumber().isNotEmpty) {
      phoneController.text = Get.find<AuthController>().getUserNumber();
    } else {
      phoneController.text = countryDialCode;
    }
    passwordController.text = Get.find<AuthController>().getUserPassword();
    if (passwordController.text != '') {
      Get.find<AuthController>().setRememberMe();
    }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.logo,
                      width: 150,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Text(
                      '${'welcome_to'.tr} ${AppConstants.appName}',
                      style: textBold.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'log_in'.tr,
                                style: textBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                ),
                              ),
                              Text(
                                'log_in_message'.tr,
                                style: textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeLarge,
                              )
                            ])
                      ],
                    ),
                    CustomTextField(
                      hintText: 'phone',
                      inputType: TextInputType.number,
                      countryDialCode: "+91",
                      controller: phoneController,
                      onCountryChanged: (CountryCode countryCode) {
                        countryDialCode = countryCode.dialCode!;
                        phoneController.text = countryDialCode;
                      },
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    CustomTextField(
                      hintText: 'password',
                      inputType: TextInputType.text,
                      prefixIcon: Images.lock,
                      inputAction: TextInputAction.done,
                      prefixHeight: 70,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () => authController.toggleRememberMe(),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    activeColor: Theme.of(context).primaryColor,
                                    value: authController.isActiveRememberMe,
                                    onChanged: (bool? isChecked) =>
                                        authController.toggleRememberMe(),
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall,
                                ),
                                Text(
                                  'remember'.tr,
                                  style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              ],
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const ForgotPasswordScreen());
                            },
                            child: Text('forgot_password'.tr,
                                style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                        )
                      ],
                    ),
                    CustomButton(
                      buttonText: 'log_in'.tr,
                      onPressed: () {
                        String phone = phoneController.text;
                        String password = passwordController.text;

                        if (phone.length < 8) {
                          showCustomSnackBar('phone_number_is_not_valid'.tr);
                        } else if (password.isEmpty) {
                          showCustomSnackBar('password_is_required'.tr);
                        } else {
                          authController.setUserToken('token');
                          // authController.login(phone, password);
                        }

                        Login(phone, password);
                      },
                      radius: 50,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: 8),
                          child: Text(
                            'or'.tr,
                            style: textRegular.copyWith(
                                color: Theme.of(context).hintColor),
                          ),
                        ),
                        const Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${'do_not_have_an_account'.tr} ',
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text('sign_up'.tr,
                              style: textRegular.copyWith(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const HtmlViewerScreen()),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text("terms_and_condition".tr,
                            style: textMedium.copyWith(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ),
                  ]),
            ),
          ));
        }),
      ),
    );
  }

  // Future<void> Login2(String phone, String password) async {
  //   print("entered");
  //   try {
  //     var url = Uri.parse('${Constant().url}dp_login');

  //     String phoneNumberWithoutCode =
  //         phone.startsWith('+91') ? phone.substring(3) : phone;

  //     var response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         "phone": phoneNumberWithoutCode,
  //         "password": password,
  //       }),
  //     );

  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');

  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     if (response.statusCode == 200) {
  //       var sharedPref = await SharedPreferences.getInstance();

  //       // var responseBody = json.decode(response.body);
  //       // String token = responseBody['token'];

  //       // SharedPreferences prefs = await SharedPreferences.getInstance();
  //       // prefs.setString('token', token);
  //       // print(token);

  //       // sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
  //       // sharedPref.setString('phone', responseData['dp']['phone']);
  //       // sharedPref.setInt('id', responseData['dp']['id']);
  //       // sharedPref.setString('name', responseData['dp']['name']);
  //       // sharedPref.setString('email', responseData['dp']['email']);
  //       // sharedPref.setBool('argumnet4', responseData['argumnet4']);
  //       // sharedPref.setBool('argumnet3', responseData['argumnet3']);
  //       // sharedPref.setBool('argumnet2', responseData['argumnet2']);
  //       // sharedPref.setBool('argumnet1', responseData['argumnet1']);

  //       sharedPref.setBool('argumnet4', responseData['status'][3]);
  //       sharedPref.setBool('argumnet3', responseData['status'][2]);
  //       sharedPref.setBool('argumnet2', responseData['status'][1]);
  //       sharedPref.setBool('argumnet1', responseData['status'][0]);

  //       // Get.to(() =>  DocumentsDashboard(argument1: false, argument2: false, argument3: false, argument4: false,));}
  //       print(responseData['status'][0]);
  //       print("_" * 25);
  //       print(await getBoolAsync("argumnet1"));
  //       if (getBoolAsync("argumnet1") &&
  //           getBoolAsync("argumnet2") &&
  //           getBoolAsync("argumnet3") &&
  //           getBoolAsync("argumnet4")) {
  //         Get.to(() => DashboardScreen());
  //       } else {
  //         Get.to(() => DocumentsDashboard(
  //               argument1: getBoolAsync("argumnet1"),
  //               argument2: getBoolAsync("argumnet2"),
  //               argument3: getBoolAsync("argumnet3"),
  //               argument4: getBoolAsync("argumnet4"),
  //             ).launch(context,
  //                 pageRouteAnimation: PageRouteAnimation.Scale,
  //                 isNewTask: true));
  //       }
  //     } else {
  //       customSnackBar('Login failed,Number Not Registred');
  //       print('Login failed with status code: ${response.statusCode}');
  //       print(response.reasonPhrase);
  //     }
  //   } catch (error) {
  //     print('Error during Login: $error');
  //   }
  // }

  Future<void> Login(String phone, String password) async {
    print("entered");
    try {
      var url = Uri.parse('${Constant().url}dp_login');

      String phoneNumberWithoutCode =
          phone.startsWith('+91') ? phone.substring(3) : phone;

      // Initialize sharedPreferences
      var sharedPreferences = await SharedPreferences.getInstance();

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "phone": phoneNumberWithoutCode,
          "password": password,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString('userId', responseData['data']['id'].toString());

        sharedPref.setBool('argumnet4', responseData['status'][3]);
        sharedPref.setBool('argumnet3', responseData['status'][2]);
        sharedPref.setBool('argumnet2', responseData['status'][1]);
        sharedPref.setBool('argumnet1', responseData['status'][0]);

        print(sharedPreferences.getBool("argumnet2"));
        print('USER ID : ${sharedPreferences.getString("userId")}');


        if ((sharedPreferences.getBool("argumnet1") ?? false) &&
            (sharedPreferences.getBool("argumnet2") ?? false) &&
            (sharedPreferences.getBool("argumnet3") ?? false) &&
            (sharedPreferences.getBool("argumnet4") ?? false)) {
          Get.to(() => DashboardScreen());
        } else {
          print(sharedPreferences.getBool("argumnet1"));
          Get.to(() => DocumentsDashboard(
                argument1: sharedPref.getBool("argumnet1") ?? false,
                argument2: sharedPref.getBool("argumnet2") ?? false,
                argument3: sharedPref.getBool("argumnet3") ?? false,
                argument4: sharedPref.getBool("argumnet4") ?? false,
              ));
        }
      } else {
        customSnackBar('Login failed,Number Not Registered');
        print('Login failed with status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error during Login: $error');
    }
  }
}
