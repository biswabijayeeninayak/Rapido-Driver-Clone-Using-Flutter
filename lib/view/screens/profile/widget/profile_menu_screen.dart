
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/chat/chat_screen.dart';
import 'package:ride_sharing_user_app/view/screens/help_and_support/help_and_support_screen.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/leaderboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/my_offer/my_offer_screen.dart';
import 'package:ride_sharing_user_app/view/screens/notification/notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/profile_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_level_widget.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_notification.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_triphistory.dart';
import 'package:ride_sharing_user_app/view/screens/review/review_screen.dart';
import 'package:ride_sharing_user_app/view/screens/setting/setting_screen.dart';
import 'package:ride_sharing_user_app/view/screens/trip/trip_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Column(children:   [
            const ProfileLevelWidget(),

            const SizedBox(height: 100,),

            ProfileMenuItem(icon: Images.profileIcon, title: 'profile', onTap: ()=> Get.to(()=> const ProfileScreen()),),
            ProfileMenuItem(icon: Images.myOfferIcon, title: 'My Rides', onTap: ()=> Get.to(()=> const ProfileTripHistoryScreen()),),
            ProfileMenuItem(icon: Images.notificationActive, title: 'Notification', onTap: ()=>  Get.to(()=> const ProfileNotificationScreen())),
            ProfileMenuItem(icon: Images.destinationIcon, title: 'Ratings', onTap: ()=> Get.to(()=> const ReviewScreen())),
            // ProfileMenuItem(icon: Images.leaderBoardIcon, title: 'leader_board', onTap: ()=> Get.to(()=> const LeaderboardScreen()),),
            ProfileMenuItem(icon: Images.helpAndSupportIcon, title: 'help_and_support', onTap: ()=> Get.to(()=> const HelpAndSupportScreen()),),
            ProfileMenuItem(icon: Images.setting, title: 'setting', onTap: ()=> Get.to(()=> const SettingScreen()),),

          ],),
           Positioned(
              child: Align(
                alignment: Alignment.bottomLeft,
                  child: Container(
                    transform: Matrix4.translationValues(0, -100, 0),
                      child:  ProfileMenuItem(icon: Images.logOutIcon, title: 'logout', onTap: (){
                        showDialog(context: context, builder: (_){
                          return ConfirmationDialog(icon: Images.logOutIcon,
                            title: 'logout'.tr,
                            description: 'do_you_want_to_log_out_this_account'.tr, onYesPressed: (){
                              Get.find<AuthController>().clearSharedData().then((condition) {
                                Get.back();
                                Get.offAll(const SignInScreen());
                            // logout();
                              }
                            
                            );

                            },);
                        });

                      },)))),
        ],
      ),
    );
  }

  

//    Future<void> logout() async {

//      SharedPreferences prefs = await SharedPreferences.getInstance();
//   // String userId = prefs.getString('userId').toString();
//   String token = prefs.getString('token').toString();
//   print(token);
//   try {
   

//     var response = await http.get(
//       Uri.parse('http://kods.tech/munsride/api/pilot_logout'),
//        headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//       print('Logout failed with status: ${response.statusCode}');
//       print('Reason: ${response.reasonPhrase}');


//     if (response.statusCode == 200) {
//       print("enter 200");
//       print('Logout failed with status: ${response.statusCode}');
//       print('Reason: ${response.reasonPhrase}');

//       print('Logout successful');

//       // Get.back();
//       Get.offAll(const SignInScreen());
//       // Additional logic for successful logout
//     } else {
//       print('Logout failed with status: ${response.statusCode}');
//       print('Reason: ${response.reasonPhrase}');
//       // Handle error response
//     }
//   } catch (error) {
//     print('Error during logout: $error');
//     // Handle any exceptions that may occur during the logout process
//   }
// }
}


class ProfileMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function()? onTap;
  const ProfileMenuItem({Key? key, required this.icon, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,),
          child: Row(children: [
            SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(icon, color: Theme.of(context).colorScheme.outline)),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            Text(title.tr, style: textSemiBold.copyWith(color: Theme.of(context).colorScheme.outline, fontSize: Dimensions.fontSizeLarge)),
          ],),
        ),
      ),
    );
  }


}
