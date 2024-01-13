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
import 'package:ride_sharing_user_app/models/VehicleDetails.dart';
import 'package:ride_sharing_user_app/view/screens/auth/commonScaffold.dart';
import 'package:ride_sharing_user_app/view/screens/auth/documents_dashboard.dart';
import 'package:ride_sharing_user_app/view/screens/auth/submitDocument.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;




class VehicleDocuments extends StatefulWidget {
  static String tag = '/VehicleDocuments';
  final bool? isGoogle;

  VehicleDocuments({this.isGoogle = false});

  @override
  VehicleDocumentsState createState() => VehicleDocumentsState();
}

class VehicleDocumentsState extends State<VehicleDocuments> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countryCode = "+91";
bool isLoading = false;

  TextEditingController modelYearController = TextEditingController();
  TextEditingController modleNumberController = TextEditingController();
  TextEditingController modleNameController = TextEditingController();
  TextEditingController vehicletypeController = TextEditingController();

  FocusNode modleYearFocus = FocusNode();
  FocusNode modleNumberFocus = FocusNode();
  FocusNode modleNameFocus = FocusNode();
  FocusNode vehicleTypeFocus = FocusNode();

  XFile? dpProfileImage;

  List<String> vehicleOptions = ['2 Wheeler', '3 Wheeler'];
  int? selectedType;
  

  DateTime selectedDate = DateTime.now(); // Default to current date
VehicleDetails? vehicleDetails;
  @override
  void initState() {
    super.initState();
    // init();

    FetchVehicleDetails();
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
          )
          .cornerRadiusWithClipRRect(100)
          .center();
  } else {
    return Icon(
      Icons.account_circle,
      size: 150,  // Set the size according to your requirements
      color: Colors.grey,  // Set the color according to your requirements
    )
    .cornerRadiusWithClipRRect(50)
    .paddingOnly(right: 4, bottom: 4)
    .center();
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
      title: const Text("Add Vehicle Details", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.orange[600],
    ),
      body: 
      isLoading?
      Center(child: CircularProgressIndicator(),):
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
                    16.height,
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
                          //       backgroundColor:Colors.orange.shade600,
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


                    Text("Model Name", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller:modleNameController,
                      textFieldType: TextFieldType.OTHER,
                      focus: modleNameFocus,
                      nextFocus: modleYearFocus,
                      decoration: commonInputDecoration(),
                      onTap: () {},
                    ),
                    16.height,


                    Text("Model Year", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller: modelYearController,
                      textFieldType: TextFieldType.NUMBER,
                      focus: modleYearFocus,
                      nextFocus: modleNumberFocus,
                      decoration: commonInputDecoration(),
                      errorThisFieldRequired: "This field is required",
                    ),
                    16.height,
            
                    Text("Model Number", style: primaryTextStyle()),
                    8.height,
                    AppTextField(
                      controller:modleNumberController,
                      textFieldType: TextFieldType.OTHER,
                      focus: modleNumberFocus,
                      nextFocus: vehicleTypeFocus,
                      decoration: commonInputDecoration(),
                      onTap: () {},
                    ),
                    16.height,

                    
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16), // Replacing '16.height' for clarity
                        Text("Vehicle Type", style: primaryTextStyle()),
                        SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: selectedType,
                          decoration: commonInputDecoration(),
                          dropdownColor: Theme.of(context).cardColor,
                          style: primaryTextStyle(),
                          items: [
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.bike_scooter),
                                  SizedBox(width: 16),
                                  Text('2 Wheeler', style: primaryTextStyle()),
                                ],
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.auto_awesome),
                                  SizedBox(width: 16),
                                  Text('3 Whleer', style: primaryTextStyle()),
                                ],
                              ),
                            ),
                          ],
                         onChanged: (int? value) {
  if (value != null) {
    setState(() {
      vehicletypeController.text = vehicleOptions[value - 1];
    });
    print("Selected vehicle: ${vehicletypeController.text}");
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
                  ],
                ),
              ),
            ),
          ),
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
    Get.to(() => DocumentsDashboard(
      argument1: false,
      argument2: false,
      argument3: false,
      argument4: false,
    ));
  }, width: MediaQuery.of(context).size.width / 2.5),
),

Padding(
  padding: const EdgeInsets.all(8.0),
  child: commonButton("Proceed", () {

    String selectedVehicleType = vehicletypeController.text;
    String vehicleno = modleNumberController.text;
    String vehicle_model_year = modelYearController.text;
    String modelName = modleNameController.text;

    if (_formKey.currentState!.validate()) {
      print(vehicletypeController.text);
      if (vehicletypeController.text.isNotEmpty) {
        saveVehicleDetails(  selectedVehicleType,  vehicleno ,  vehicle_model_year,  modelName);
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

  
Widget commonButton(String title, Function() onTap, {double? width, Color? color, Color? textColor}) {
  return SizedBox(
    width: width,
    child: AppButton(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
      elevation: 0,
      child: Text(
        title,
        style: boldTextStyle(color: textColor ?? white),
      ),
      color: color ??Colors.orange.shade600,
      onTap: onTap,
    ),
  );
}


InputDecoration commonInputDecoration({String? hintText, IconData? suffixIcon, Function()? suffixOnTap, Widget? dateTime, Widget? prefixIcon, bool? isFill = true}) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(16),
    filled: true,
    prefixIcon: prefixIcon,
    isDense: true,
    hintText: hintText != null ? hintText : '',
    hintStyle: secondaryTextStyle(size: 16, color: Colors.grey),
    fillColor:Colors.orange.shade600.withOpacity(0.06),
    counterText: '',
    suffixIcon: dateTime != null
        ? dateTime
        : suffixIcon != null
            ? Icon(suffixIcon, color:Colors.orange.shade600, size: 22).onTap(suffixOnTap)
            : null,
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color:Colors.orange.shade600), borderRadius: BorderRadius.circular(defaultRadius)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.orange.shade600), borderRadius: BorderRadius.circular(defaultRadius)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
  );
}

Future<void> saveVehicleDetails( String selectedVehicleType, String vehicleno , String vehicle_model_year, String modelName) async {
  
 SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId').toString();
    try {
      var url = Uri.parse('http://kods.tech/munsride/api/storeDocumentss/$userId');

    

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "vehicle_type": selectedVehicleType,
          "vehicleno": vehicleno,
          "vehicle_model_year": vehicle_model_year,
          "modelName": modelName,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
         Get.to(() => SubmitDocuments());
      } else {
        print('Vehicle details upload failed with status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error during Vehicle details upload: $error');
    }
  }

  // Future<void> FetchVehicleDetails() async {

  //    SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String userId = prefs.getString('userId').toString();
  //   try {
  //     // Replace 'your_api_url' with the actual API endpoint
  //     final response = await http.get(Uri.parse('http://kods.tech/munsride/api/dp_vehicledetails/${userId.toString()}'));

  //     if (response.statusCode == 200) {
  //       // If the server returns a 200 OK response, parse the data
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       setState(() {
  //         // Update the driverDetails variable with the fetched data
  //         vehicleDetails = VehicleDetails.fromJson(data);
  //         // print(driverDetails!.data!.email);

  //         if (vehicleDetails!.data!.modelName != "null" ||vehicleDetails!.data!.modelName != "" ) {
  //           modleNameController.text = vehicleDetails!.data!.modelName! ;
  //           modelYearController.text = vehicleDetails!.data!.vehicleModelYear.toString();
  //           modleNumberController.text = vehicleDetails!.data!.vehicleNumber!;
  //           vehicletypeController.text = vehicleDetails!.data!.vehicleType!;

  //           }

  //           isLoading= false;
  //       });

        
  //     } else {
  //       // If the server did not return a 200 OK response, throw an exception
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     // Handle errors accordingly
  //   }
  // }

Future<void> FetchVehicleDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId').toString();

  try {
    final response = await http.get(Uri.parse('http://kods.tech/munsride/api/dp_vehicledetails/${userId.toString()}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        vehicleDetails = VehicleDetails.fromJson(data);

        if (vehicleDetails!.data!.modelName != "null" || vehicleDetails!.data!.modelName != "") {
          modleNameController.text = vehicleDetails!.data!.modelName!;
          modelYearController.text = vehicleDetails!.data!.vehicleModelYear.toString();
          modleNumberController.text = vehicleDetails!.data!.vehicleNumber!;
          isLoading = false;
        }

        // Check if vehicle type is not null or empty before updating the controller
        if (vehicleDetails!.data!.vehicleType != null && vehicleDetails!.data!.vehicleType!.isNotEmpty) {
          vehicletypeController.text = vehicleDetails!.data!.vehicleType!;
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print('Error fetching data: $error');
  }
}

}
