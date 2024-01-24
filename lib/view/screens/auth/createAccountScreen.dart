import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ride_sharing_user_app/models/DriverDetails.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/view/screens/auth/documents_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';

class CreateAccount extends StatefulWidget {
  static String tag = '/CreateAccount';
  final bool? isGoogle;

  CreateAccount({this.isGoogle = false});

  @override
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countryCode = "+91";
// bool isLoading = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController dpGenderController = TextEditingController();
  TextEditingController dpnameController = TextEditingController();
  TextEditingController dpcontactNumberController = TextEditingController();
  TextEditingController dpdobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode dpGenderFocus = FocusNode();
  FocusNode dpnameFocus = FocusNode();
  FocusNode dpcontactFocus = FocusNode();
  FocusNode dpdobFocus = FocusNode();
  FocusNode addressFocus = FocusNode();

  XFile? dpProfileImage;

 List<String> genderOptions = ['Male', 'Female', 'Other'];
String? selectedGender; 

  DateTime selectedDate = DateTime.now();

  DriverDetails? driverDetails;

  // Future<void> FetchDriverDetails() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userId = prefs.getString('userId').toString(); 
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://kods.tech/munsride/api/dp_create_account/${userId.toString()}'));

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       setState(() {
  //         driverDetails = DriverDetails.fromJson(data);

  //         if (driverDetails!.data!.userName != "null" ||
  //             driverDetails!.data!.userName != "") {
  //           dpnameController.text = driverDetails!.data!.userName!;
  //           dpdobController.text = driverDetails!.data!.dob!;
  //           emailController.text = driverDetails!.data!.email!;
  //           addressController.text = driverDetails!.data!.address!;
  //           dpcontactNumberController.text = driverDetails!.data!.mobile!;
  //           selectedGender=driverDetails!.data!.gender!;
  //         } 

  //       });
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //   }
  // }

  
  Future<void> FetchDriverDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId').toString();
  String token = prefs.getString('token').toString();
  try {

    var response = await http.get(
      Uri.parse('http://kods.tech/munsride/api/dp_create_account/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(response.body);

      setState(() {
        driverDetails = DriverDetails.fromJson(data);

        if (driverDetails!.data!.userName != "null" ||
            driverDetails!.data!.userName != "") {
          dpnameController.text = driverDetails!.data!.userName!;
          dpdobController.text = driverDetails!.data!.dob!;
          emailController.text = driverDetails!.data!.email!;
          addressController.text = driverDetails!.data!.address!;
          dpcontactNumberController.text = driverDetails!.data!.mobile!;
          selectedGender = driverDetails!.data!.gender!;
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print('Error fetching data: $error');
  }
}




  Future<void> CreateAccount(String userName, String dob, String email,
      String gender, String phone, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String token = prefs.getString('token') ?? ""; 
    try {
      var url =
          Uri.parse('http://kods.tech/munsride/api/dp_save_details/$userId');

      var response = await http.post(
        url,
       headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "name": userName,
          "dob": dob,
          "email": email,
          "gender": gender,
          "mobile": phone,
          "address": address,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
      var sharedPref = await SharedPreferences.getInstance();

              //  Get.to(() => DocumentsDashboard(argument1: getBoolAsync("argument1"), argument2: getBoolAsync("argument2"), argument3: getBoolAsync("argument3"), argument4: getBoolAsync("argument4")));
                 Get.to(() => DocumentsDashboard(
                argument1: sharedPref.getBool("argumnet1") ?? false,
                argument2: sharedPref.getBool("argumnet2") ?? false,
                argument3: sharedPref.getBool("argumnet3") ?? false,
                argument4: sharedPref.getBool("argumnet4") ?? false,
              ));

// Get.to(() => const DocumentsDashboard(
//               argument1: false,
//               argument2: false,
//               argument3: false,
//               argument4: false,
//             ));
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error during registration: $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dpdobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // init();

    FetchDriverDetails();
  }

  // Future<void> init() async {
  //   String phoneNum = getStringAsync(DP_CONTACT_NUMBER);
  //   emailController.text = getStringAsync(DP_EMAIL);
  //   dpnameController.text = getStringAsync(DP_NAME);
  // }

  Widget profileImage() {
    if (dpProfileImage != null) {
      return Image.file(
        File(dpProfileImage!.path),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ).cornerRadiusWithClipRRect(100).center();
    } else {
      return Icon(
        Icons.account_circle,
        size: 150, // Set the size according to your requirements
        color: Colors.grey, // Set the color according to your requirements
      ).cornerRadiusWithClipRRect(50).paddingOnly(right: 4, bottom: 4).center();
    }
  }

  Future<void> getImage() async {
    dpProfileImage = null;
    dpProfileImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {});
  }

  // Future<void> save() async {
  //   appStore.setLoading(true);
  //   await updateProfile(
  //     file:
  //         dpProfileImage != null ? File(dpProfileImage!.path.validate()) : null,
  //     name: dpnameController.text.validate(),
  //     userName: dpGenderController.text.validate(),
  //     userEmail: emailController.text.validate(),
  //     address: dpdobController.text.validate(),
  //     contactNumber: '$countryCode ${dpcontactNumberController.text.trim()}',
  //   ).then((value) {
  //     // finish(context);
  //   }).catchError((error) {
  //     log(error);
  //     appStore.setLoading(false);
  //   });
  // }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Account",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[600],
      ),
      body:
          // isLoading?
          // Center(child: CircularProgressIndicator(),):

          Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3.height,
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: profileImage(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          // child: Container(
                          //   margin: EdgeInsets.only(top: 130, left: 80),
                          //   padding: EdgeInsets.all(6),
                          //   decoration: boxDecorationWithRoundedCorners(
                          //       backgroundColor: Colors.orange.shade600,
                          //       border: Border.all(width: 1, color: Colors.white),
                          //       boxShape: BoxShape.circle),
                          //   child: Icon(
                          //     Icons.edit,
                          //     color: white,
                          //     size: 16,
                          //   ),
                          // ),
                        )
                      ],
                    ).onTap(() {
                      getImage();
                    },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    16.height,
                    Text("Name", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: dpnameController,
                      textFieldType: TextFieldType.NAME,
                      focus: dpnameFocus,
                      nextFocus: dpdobFocus,
                      decoration: commonInputDecoration(),
                      errorThisFieldRequired: "This field is required",
                    ),
                    16.height,
                    Text("Date of Birth(YYYY-MM-DD)",
                        style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: dpdobController,
                      textFieldType: TextFieldType.OTHER,
                      focus: dpdobFocus,
                      nextFocus: emailFocus,
                      textInputAction: TextInputAction.done,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: commonInputDecoration(),
                      errorThisFieldRequired: "This field is required",
                    ),
                    16.height,
                    Text("Email", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: emailController,
                      textFieldType: TextFieldType.EMAIL,
                      focus: emailFocus,
                      nextFocus: dpGenderFocus,
                      decoration: commonInputDecoration(),
                      onTap: () {},
                    ),
                    16.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 16), // Replacing '16.height' for clarity
                        Text("Gender", style: primaryTextStyle()),

                        SizedBox(height: 8),
                       DropdownButtonFormField<String>( // Change type to String
      isExpanded: true,
      value: selectedGender,
      decoration: commonInputDecoration(),
      dropdownColor: Theme.of(context).cardColor,
      style: primaryTextStyle(),
      items: [
        DropdownMenuItem<String>( // Change type to String
          value: 'Male', // Update to String
          child: Row(
            children: [
              Icon(Icons.male_rounded),
              SizedBox(width: 16),
              Text('Male', style: primaryTextStyle()),
            ],
          ),
        ),
        DropdownMenuItem<String>( // Change type to String
          value: 'Female', // Update to String
          child: Row(
            children: [
              Icon(Icons.female_rounded),
              SizedBox(width: 16),
              Text('Female', style: primaryTextStyle()),
            ],
          ),
        ),
        DropdownMenuItem<String>( // Change type to String
          value: 'Other', // Update to String
          child: Row(
            children: [
              Icon(Icons.outlet_sharp),
              SizedBox(width: 16),
              Text('Other', style: primaryTextStyle()),
            ],
          ),
        ),
      ],
      onChanged: (String? value) { // Change type to String
        if (value != null) {
          setState(() {
            dpGenderController.text = value;
          });
          print("Selected Gender: ${dpGenderController.text}");
        }
      },
      validator: (value) {
        if (value == null) return errorThisFieldRequired;
        return null;
      },
    ),
 
                      ],
                    ),
                    16.height,
                    Text("ContactNumber", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: dpcontactNumberController,
                      textFieldType: TextFieldType.PHONE,
                      // readOnly: !widget.isGoogle.validate(),
                      focus: dpcontactFocus,
                      decoration: commonInputDecoration(
                        prefixIcon: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CountryCodePicker(
                                initialSelection: countryCode,
                                showCountryOnly: false,
                                dialogSize: Size(60, 60),
                                showFlag: true,
                                enabled: widget.isGoogle.validate(),
                                showFlagDialog: true,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                textStyle: primaryTextStyle(),
                                dialogBackgroundColor:
                                    Theme.of(context).cardColor,
                                barrierColor: Colors.black12,
                                dialogTextStyle: primaryTextStyle(),
                                searchDecoration: InputDecoration(
                                  iconColor: Theme.of(context).dividerColor,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange.shade600)),
                                ),
                                searchStyle: primaryTextStyle(),
                                onInit: (c) {
                                  countryCode = c!.dialCode!;
                                },
                                onChanged: (c) {
                                  countryCode = c.dialCode!;
                                },
                              ),
                              VerticalDivider(
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty)
                          return "This field is required";
                        //  if (value.trim().length < minContactLength || value.trim().length > maxContactLength) return language.contactLength;
                        return null;
                      },
                      onTap: () {
                        // if (!widget.isGoogle.validate())
                        //   toast(language.notChangeMobileNo);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                    ),
                    16.height,
                    Text("Address", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: addressController,
                      textFieldType: TextFieldType.OTHER,
                      focus: addressFocus,
                      decoration: commonInputDecoration(),
                      onTap: () {},
                    ),
                    16.height,
                  ],
                ),
              ),
            ),
          ),
          // Observer(builder: (_) => loaderWidget().visible(appStore.isLoading)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonButton("Cancel", () {
            //     Get.to(() => const DocumentsDashboard(
            //   argument1: false,
            //   argument2: false,
            //   argument3: false,
            //   argument4: false,
            // ));
                       Get.to(() => DocumentsDashboard(argument1: getBoolAsync("argument1"), argument2: getBoolAsync("argument2"), argument3: getBoolAsync("argument3"), argument4: getBoolAsync("argument4")));

              }, width: MediaQuery.of(context).size.width / 2.5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonButton("Save", () {
                String userName = dpnameController.text;
                String dob = dpdobController.text;
                String email = emailController.text;
                String gender = dpGenderController.text;
                String phone = dpcontactNumberController.text;
                String address = addressController.text;

                if (_formKey.currentState!.validate()) {
                  if (dpGenderController.text.isNotEmpty &&
                      dpdobController.text.isNotEmpty) {
                    CreateAccount(userName, dob, email, gender, phone, address);
                  } else {
                    toast("All fields are required!");
                  }
                }
              }, width: MediaQuery.of(context).size.width / 2.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonButton(String title, Function() onTap,
      {double? width, Color? color, Color? textColor}) {
    return SizedBox(
      width: width,
      child: AppButton(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius)),
        elevation: 0,
        child: Text(
          title,
          style: boldTextStyle(color: textColor ?? white),
        ),
        color: color ?? Colors.orange.shade600,
        onTap: onTap,
      ),
    );
  }

  InputDecoration commonInputDecoration(
      {String? hintText,
      IconData? suffixIcon,
      Function()? suffixOnTap,
      Widget? dateTime,
      Widget? prefixIcon,
      bool? isFill = true}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(16),
      filled: true,
      prefixIcon: prefixIcon,
      isDense: true,
      hintText: hintText != null ? hintText : '',
      hintStyle: secondaryTextStyle(size: 16, color: Colors.grey),
      fillColor: Colors.orange.shade600?.withOpacity(0.06),
      counterText: '',
      suffixIcon: dateTime != null
          ? dateTime
          : suffixIcon != null
              ? Icon(suffixIcon, color: Colors.orange.shade600, size: 22)
                  .onTap(suffixOnTap)
              : null,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Colors.orange.shade600),
          borderRadius: BorderRadius.circular(defaultRadius)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange.shade600),
          borderRadius: BorderRadius.circular(defaultRadius)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(defaultRadius)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(defaultRadius)),
    );
  }
}
