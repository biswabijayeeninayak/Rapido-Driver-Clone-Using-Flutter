import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/profiledata.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileLevelWidget extends StatelessWidget {
  const ProfileLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileData>(
      future: fetchPilotDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Data has been successfully fetched
          ProfileData profileData = snapshot.data!;
          String userName = profileData.data.pilot.userName;
          String image = profileData.data.pilot.image;

          return Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimensions.paddingSizeDefault,
              100,
              Dimensions.paddingSizeDefault,
              Dimensions.paddingSizeDefault,
            ),
            child: Row(
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        Dimensions.paddingSizeExtraSmall),
                    child: CustomImage(
                      width: 40,
                      height: 40,
                      image: image, // Use the image URL from the backend
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName, // Display the user name from the backend
                        style: textBold.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(.10),
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraSmall),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<ProfileController>().toggleDrawer(),
                  child: const SizedBox(
                    child: Icon(CupertinoIcons.clear, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
      },
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
            updatedAt: DateTime.now(),
          ),
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
  
}
