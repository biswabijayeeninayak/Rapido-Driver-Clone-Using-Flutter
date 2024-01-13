
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
import 'package:ride_sharing_user_app/view/screens/profile/profile_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_level_widget.dart';
import 'package:ride_sharing_user_app/view/screens/review/review_screen.dart';
import 'package:ride_sharing_user_app/view/screens/setting/setting_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';

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

            const SizedBox(height: 50,),

             ProfileMenuItem(icon: Images.profileIcon, title: 'profile', onTap: ()=> Get.to(()=> const ProfileScreen()),),
             ProfileMenuItem(icon: Images.myOfferIcon, title: 'my_offer', onTap: ()=> Get.to(()=> const MyOfferScreen()),),
            ProfileMenuItem(icon: Images.message, title: 'message', onTap: ()=>  Get.to(()=> const ChatScreen())),
            ProfileMenuItem(icon: Images.destinationIcon, title: 'my_reviews', onTap: ()=> Get.to(()=> const ReviewScreen())),
            ProfileMenuItem(icon: Images.leaderBoardIcon, title: 'leader_board', onTap: ()=> Get.to(()=> const LeaderboardScreen()),),
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
                              });

                            },);
                        });

                      },)))),
        ],
      ),
    );
  }
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
