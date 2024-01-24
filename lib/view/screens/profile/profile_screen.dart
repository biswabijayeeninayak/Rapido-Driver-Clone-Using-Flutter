import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/models/VehicleDetails.dart';
import 'package:ride_sharing_user_app/models/VehicleDetails.dart';
import 'package:ride_sharing_user_app/models/VehicleDetails.dart';
import 'package:ride_sharing_user_app/models/VehicleDetails.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/profiledata.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/edit_profile.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_item.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_type_button_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/VehicleDetails.dart';

// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<ProfileController>(
//         builder: (profileController) {
//           return Column(
//             children: [
//               CustomAppBar(
//                 title: 'profile'.tr,
//                 showBackButton: true,
//                 onTap: () {
//                   Get.find<ProfileController>().toggleDrawer();
//                 },
//               ),
//               Container(
//                 transform: Matrix4.translationValues(0, -25, 0),
//                 child: SizedBox(
//                   height: Get.find<LocalizationController>().isLtr ? 45 : 50,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: profileController.profileType.length,
//                     itemBuilder: (context, index) {
//                       return ProfileTypeButtonWidget(
//                           profileTypeName: profileController.profileType[index], index: index);
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                     Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
//                 child: FutureBuilder<ProfileData>(
//                   future: fetchPilotDetails(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData) {
//                       return Text('No data available');
//                     } else {
//                       final Pilot pilot = snapshot.data!.data.pilot;
//                       return Column(
//                         children: [
//                           SizedBox(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//                               child: CustomImage(
//                                 width: 80,
//                                 height: 80,
//                                 image: pilot.image, // Use the pilot image URL from the fetched data
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeDefault),
//                           InkWell(
//                             highlightColor: Colors.transparent,
//                             hoverColor: Colors.transparent,
//                             onTap: () => Get.to(() => const ProfileEditScreen()),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   pilot.userName, // Use the pilot name from the fetched data
//                                   style: textBold.copyWith(
//                                     color: Theme.of(context).primaryColor,
//                                     fontSize: Dimensions.fontSizeLarge,
//                                   ),
//                                 ),
//                                 const SizedBox(width: Dimensions.paddingSizeSmall),
//                                 if (profileController.profileTypeIndex == 0)
//                                   SizedBox(
//                                     width: Dimensions.iconSizeMedium,
//                                     child: Image.asset(Images.editIcon),
//                                   ),
//                                 const SizedBox(width: Dimensions.paddingSizeSmall),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Text('${'your_ratting'.tr} : ${pilot.avgrating ?? 0} '), // Use the pilot's average rating from the fetched data
//                               const Icon(Icons.star_rounded, color: Colors.orange, size: Dimensions.iconSizeSmall),
//                             ],
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeExtraLarge),
//                           profileController.profileTypeIndex == 0
//                               ? Column(
//                                   children: [
//                                     ProfileItem(title: 'status', value: pilot.status, isStatus: true),
//                                     ProfileItem(title: 'my_area', value: pilot.address), // Use the pilot address from the fetched data
//                                     ProfileItem(title: 'contact', value: pilot.mobile),
//                                     ProfileItem(title: 'mail_address', value: pilot.email),
//                                     ProfileItem(title: 'my_address', value: pilot.address),
//                                   ],
//                                 )
//                               : Column(
//                                   children: [
//                                     ProfileItem(title: 'vehicle', value: 'Car'),
//                                     ProfileItem(title: 'vehicle_brand', value: 'Toyota'),
//                                     ProfileItem(title: 'vehicle_model', value: 'Corolla - E140',),
//                                     ProfileItem(title: 'vin', value: '3246276426',),
//                                     ProfileItem(title: 'number_plate', value: 'DH- 723487',),
//                                   ],
//                                 ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

// Future<ProfileData> fetchPilotDetails() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String id = prefs.getString('userId').toString();
//   print(id);
//   String token = prefs.getString('token').toString();

//   try {
//     var response = await http.get(
//       Uri.parse('http://kods.tech/munsride/api/pilot_profile/$id'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       print("HIII");
//       print(response.body);

//       return ProfileData.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load pilot details');
//     }
//   } catch (e) {
//     throw Exception('Failed to connect to the server: $e');
//   }
// }

// }

/////////used code
// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: GetBuilder<ProfileController>(
//         builder: (profileController) {
//           return Column(
//             children: [
//               CustomAppBar(
//                 title: 'profile'.tr,
//                 showBackButton: true,
//                 onTap: () {
//                   Get.find<ProfileController>().toggleDrawer();
//                 },
//               ),
//               Container(
//                 transform: Matrix4.translationValues(0, -25, 0),
//                 child: SizedBox(
//                   height: Get.find<LocalizationController>().isLtr ? 45 : 50,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: profileController.profileType.length,
//                     itemBuilder: (context, index) {
//                       return ProfileTypeButtonWidget(
//                           profileTypeName: profileController.profileType[index],
//                           index: index);
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                     Dimensions.paddingSizeDefault,
//                     Dimensions.paddingSizeDefault,
//                     Dimensions.paddingSizeDefault,
//                     0),
//                 child: FutureBuilder<ProfileData>(
//                   future: fetchPilotDetails(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       final ProfileData profileData = snapshot.data!;
//                       final Pilot? pilot = profileData.data.pilot;
//                       if (pilot != null) {
//                         return Column(
//                           children: [
//                             SizedBox(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(
//                                     Dimensions.paddingSizeSmall),
//                                 child: CustomImage(
//                                   width: 80,
//                                   height: 80,
//                                   image: pilot.image,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                                 height: Dimensions.paddingSizeDefault),
//                             InkWell(
//                               highlightColor: Colors.transparent,
//                               hoverColor: Colors.transparent,
//                               onTap: () =>
//                                   Get.to(() => const ProfileEditScreen()),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     pilot.userName,
//                                     style: textBold.copyWith(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: Dimensions.fontSizeLarge,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                       width: Dimensions.paddingSizeSmall),
//                                   if (profileController.profileTypeIndex == 0)
//                                     SizedBox(
//                                       width: Dimensions.iconSizeMedium,
//                                       child: Image.asset(Images.editIcon),
//                                     ),
//                                   const SizedBox(
//                                       width: Dimensions.paddingSizeSmall),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                                 height: Dimensions.paddingSizeExtraSmall),
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.star_rounded,
//                                     color: Colors.orange,
//                                     size: Dimensions.iconSizeSmall),
//                                 Text(
//                                   '${'your_rating'.tr} : ${pilot.avgrating?.toString() ?? 'N/A'}',
//                                   style: textRegular.copyWith(
//                                       color: Theme.of(context).hintColor),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                                 height: Dimensions.paddingSizeExtraLarge),
//                             profileController.profileTypeIndex == 0
//                                 ? Column(
//                                     children: [
//                                       // ProfileItem(
//                                       //     title: 'status',
//                                       //     value: pilot.status,
//                                       //     isStatus: true),
//                                       ProfileItem(
//                                           title: 'my_area',
//                                           value: pilot.address),
//                                       ProfileItem(
//                                           title: 'contact',
//                                           value: pilot.mobile),
//                                       ProfileItem(
//                                           title: 'mail_address',
//                                           value: pilot.email),
//                                       ProfileItem(
//                                           title: 'my_address',
//                                           value: pilot.address),
//                                     ],
//                                   )
//                                 : Column(
//                                     children: [
//                                       ProfileItem(
//                                           title: 'vehicle', value: 'Car'),
//                                       ProfileItem(
//                                           title: 'vehicle_brand',
//                                           value: 'Toyota'),
//                                       ProfileItem(
//                                         title: 'vehicle_model',
//                                         value: 'Corolla - E140',
//                                       ),
//                                       ProfileItem(
//                                         title: 'vin',
//                                         value: '3246276426',
//                                       ),
//                                       ProfileItem(
//                                         title: 'number_plate',
//                                         value: 'DH- 723487',
//                                       ),
//                                     ],
//                                   ),
//                           ],
//                         );
//                       } else {
//                         return Text('Pilot data is null');
//                       }
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }
//                      else {
//                       return CircularProgressIndicator();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Future<ProfileData> fetchPilotDetails() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String id = prefs.getString('userId').toString();
//   //   print(id);
//   //   String token = prefs.getString('token').toString();

//   //   try {
//   //     var response = await http.get(
//   //       Uri.parse('http://kods.tech/munsride/api/pilot_profile/$id'),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );
//   //     if (response.statusCode == 200) {
//   //       print("HIII");
//   //       print(response.body);

//   //       return ProfileData.fromJson(json.decode(response.body));
//   //     } else {
//   //       throw Exception('Failed to load pilot details');
//   //     }
//   //   } catch (e) {
//   //     print('Error in API call: $e');
//   //     throw Exception('Failed to connect to the server: $e');
//   //   }
//   // }

//   Future<ProfileData> fetchPilotDetails() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String id = prefs.getString('userId').toString();
//   print(id);
//   String token = prefs.getString('token').toString();

//   try {
//     var response = await http.get(
//       Uri.parse('http://kods.tech/munsride/api/pilot_profile/$id'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       print("HIII");
//       print(response.body);

//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       Map<String, dynamic> pilotData = jsonResponse['data']['pilot'];

//       // Extracting details
//       int pilotId = pilotData['id'];
//       int authId = pilotData['auth_id'];
//       String userName = pilotData['user_name'];
//       String dob = pilotData['dob'];
//       String email = pilotData['email'];
//       String gender = pilotData['gender'];
//       String mobile = pilotData['mobile'];
//       String address = pilotData['address'];
//       String image = pilotData['image'];
//       String status = pilotData['status'];
//       String action = pilotData['action'];
//       String currentLat = pilotData['current_lat'];
//       String currentLng = pilotData['current_lng'];
//       DateTime createdAt = DateTime.parse(pilotData['created_at']);
//       DateTime updatedAt = DateTime.parse(pilotData['updated_at']);

//       // Create a Pilot instance
//       Pilot pilot = Pilot(
//         id: pilotId,
//         authId: authId,
//         userName: userName,
//         dob: DateTime.parse(dob),
//         email: email,
//         gender: gender,
//         mobile: mobile,
//         address: address,
//         image: image,
//         status: status,
//         action: action,
//         currentLat: currentLat,
//         currentLng: currentLng,
//         createdAt: createdAt,
//         updatedAt: updatedAt,
//         assignedRides: [], // You may need to handle assigned rides accordingly
//         auth: Auth(id: 0, userType: '', userName: '', email: '', phone: 0, password: '', image: '', fromState: '', city: '', createdAt: DateTime.now(), updatedAt: DateTime.now()),
//       );

//       // Create a Data instance
//       Data data = Data(
//         pilot: pilot,
//         days: jsonResponse['data']['days'],
//         avgrating: pilotData['avgrating'],
//       );

//       // Create a ProfileData instance
//       ProfileData profileData = ProfileData(
//         status: jsonResponse['status'],
//         message: jsonResponse['message'],
//         data: data,
//       );

//       return profileData;
//     } else {
//       throw Exception('Failed to load pilot details');
//     }
//   } catch (e) {
//     print('Error in API call: $e');
//     throw Exception('Failed to connect to the server: $e');
//   }
// }

// }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileData> _profileData;
  TextEditingController modelYearController = TextEditingController();
  TextEditingController modleNumberController = TextEditingController();
  TextEditingController modleNameController = TextEditingController();
  TextEditingController vehicletypeController = TextEditingController();

  VehicleDetails? vehicleDetails; // Define vehicleDetails here

  @override
  void initState() {
    super.initState();
    _profileData = fetchPilotDetails();
    FetchVehicleDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Column(
            children: [
              CustomAppBar(
                title: 'profile'.tr,
                showBackButton: true,
                onTap: () {
                  Get.find<ProfileController>().toggleDrawer();
                },
              ),
              Container(
                transform: Matrix4.translationValues(0, -25, 0),
                child: SizedBox(
                  height: Get.find<LocalizationController>().isLtr ? 45 : 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: profileController.profileType.length,
                    itemBuilder: (context, index) {
                      return ProfileTypeButtonWidget(
                        profileTypeName: profileController.profileType[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,
                  0,
                ),
                child: FutureBuilder<ProfileData>(
                  future: _profileData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final ProfileData profileData = snapshot.data!;
                      final Pilot? pilot = profileData.data.pilot;
                      if (pilot != null) {
                        return Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeSmall,
                                ),
                                child: CustomImage(
                                  width: 80,
                                  height: 80,
                                  image: pilot.image,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                            InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () =>
                                  Get.to(() => const ProfileEditScreen()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    pilot.userName,
                                    style: textBold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                  if (profileController.profileTypeIndex == 0)
                                    SizedBox(
                                      width: Dimensions.iconSizeMedium,
                                      child: Image.asset(Images.editIcon),
                                    ),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded,
                                    color: Colors.orange,
                                    size: Dimensions.iconSizeSmall),
                                Text(
                                  '${'your_rating'.tr} : ${pilot.avgrating?.toString() ?? 'N/A'}',
                                  style: textRegular.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge),
                            profileController.profileTypeIndex == 0
                                ? Column(
                                    children: [
                                      // ProfileItem(
                                      //     title: 'status',
                                      //     value: pilot.status,
                                      //     isStatus: true),
                                      ProfileItem(
                                          title: 'my_area',
                                          value: pilot.address),
                                      ProfileItem(
                                          title: 'contact',
                                          value: pilot.mobile),
                                      ProfileItem(
                                          title: 'mail_address',
                                          value: pilot.email),
                                      ProfileItem(
                                          title: 'my_address',
                                          value: pilot.address),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      ProfileItem(
                                        title: 'vehicle',
                                        value:
                                            vehicleDetails?.data?.modelName ??
                                                'N/A',
                                      ),
                                      // ProfileItem(
                                      //   title: 'vehicle_brand',
                                      //   value: vehicleDetails?.data?.modelName ?? 'N/A',
                                      // ),
                                      ProfileItem(
                                        title: 'vehicle_model',
                                        value: vehicleDetails
                                                ?.data?.vehicleModelYear
                                                .toString() ??
                                            'N/A',
                                      ),
                                      ProfileItem(
                                        title: 'Vehicle Type',
                                        value:
                                            vehicleDetails?.data?.vehicleType ??
                                                'N/A',
                                      ),
                                      ProfileItem(
                                        title: 'number_plate',
                                        value: vehicleDetails
                                                ?.data?.vehicleNumber ??
                                            'N/A',
                                      ),
                                    ],
                                  ),
                          ],
                        );
                      } else {
                        return Text('Pilot data is null');
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<ProfileData> fetchPilotDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId').toString();
    print(id);
    String token = prefs.getString('token').toString();

    try {
      var response = await http.get(
        Uri.parse('http://kods.tech/munsride/api/pilot_profile/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print("HIII");
        print(response.body);

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> pilotData = jsonResponse['data']['pilot'];

        // Extracting details
        int pilotId = pilotData['id'];
        int authId = pilotData['auth_id'];
        String userName = pilotData['user_name'];
        String dob = pilotData['dob'];
        String email = pilotData['email'];
        String gender = pilotData['gender'];
        String mobile = pilotData['mobile'];
        String address = pilotData['address'];
        String image = pilotData['image'];
        String status = pilotData['status'];
        String action = pilotData['action'];
        String currentLat = pilotData['current_lat'];
        String currentLng = pilotData['current_lng'];
        DateTime createdAt = DateTime.parse(pilotData['created_at']);
        DateTime updatedAt = DateTime.parse(pilotData['updated_at']);

        // Create a Pilot instance
        Pilot pilot = Pilot(
          id: pilotId,
          authId: authId,
          userName: userName,
          dob: DateTime.parse(dob),
          email: email,
          gender: gender,
          mobile: mobile,
          address: address,
          image: image,
          status: status,
          action: action,
          currentLat: currentLat,
          currentLng: currentLng,
          createdAt: createdAt,
          updatedAt: updatedAt,
          assignedRides: [], // You may need to handle assigned rides accordingly
          auth: Auth(
              id: 0,
              userType: '',
              userName: '',
              email: '',
              phone: 0,
              password: '',
              image: '',
              fromState: '',
              city: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()),
        );

        // Create a Data instance
        Data data = Data(
          pilot: pilot,
          days: jsonResponse['data']['days'],
          avgrating: pilotData['avgrating'],
        );

        // Create a ProfileData instance
        ProfileData profileData = ProfileData(
          status: jsonResponse['status'],
          message: jsonResponse['message'],
          data: data,
        );

        return profileData;
      } else {
        throw Exception('Failed to load pilot details');
      }
    } catch (e) {
      print('Error in API call: $e');
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> FetchVehicleDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    try {
      final response = await http.get(Uri.parse(
          'http://kods.tech/munsride/api/dp_vehicledetails/${userId.toString()}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          vehicleDetails = VehicleDetails.fromJson(data);

          if (vehicleDetails!.data!.modelName != "null" ||
              vehicleDetails!.data!.modelName != "") {
            modleNameController.text = vehicleDetails!.data!.modelName!;
            modelYearController.text =
                vehicleDetails!.data!.vehicleModelYear.toString();
            modleNumberController.text = vehicleDetails!.data!.vehicleNumber!;

            // isLoading = false;
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
