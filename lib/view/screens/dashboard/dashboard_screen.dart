import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageStorageBucket bucket = PageStorageBucket();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if (Get.find<BottomMenuController>().currentTab != 0) {
          if(Get.find<ProfileController>().toggle){
            Get.find<ProfileController>().toggleDrawer();
            Get.find<BottomMenuController>().selectHomePage();
          }else{
            Get.find<BottomMenuController>().selectHomePage();
          }

          return false;
        } else {
          if(Get.find<ProfileController>().toggle){
            Get.find<ProfileController>().toggleDrawer();
          }else{
           showDialog(context: context, builder: (context){
             return ConfirmationDialog(
               icon: Images.logOutIcon,
               description: 'do_you_want_to_exit_the_app'.tr,
               onYesPressed:(){
               SystemNavigator.pop();
             },);
           });
          }

          return false;

        }
      },

      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              PageStorage(bucket: bucket, child: menuController.currentScreen),
              Positioned(child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Container(height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [BoxShadow(
                          offset: const Offset(0,4),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.3),
                        )]
                    ),



                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomMenuItem(index: 0,name: 'home',activeIcon:  Images.homeActive,inActiveIcon: Images.homeOutline, currentIndex: menuController.currentTab,
                              tap: () => menuController.selectHomePage()),
                        ),
                        Expanded(
                          child: CustomMenuItem(index: 1,name: 'activity',activeIcon:  Images.activityActive,inActiveIcon: Images.activityOutline, currentIndex: menuController.currentTab,
                              tap: () => menuController.selectActivityScreen()),
                        ),
                        Expanded(
                          child: CustomMenuItem(index: 2,name: 'notification',activeIcon:  Images.notificationActive,inActiveIcon: Images.notificationOutline, currentIndex: menuController.currentTab,
                              tap: () => menuController.selectNotificationScreen()),
                        ),
                        Expanded(
                          child: CustomMenuItem(index: 3,name: 'money',activeIcon:  Images.moneyActive,inActiveIcon: Images.moneyOutline, currentIndex: menuController.currentTab,
                              tap: () => menuController.selectWalletScreen()),
                        ),

                      ],
                    ),
                  ),
                ),))
            ],
          ),

        );
      }),
    );


  }

}

class CustomMenuItem extends StatelessWidget {
  final int index;
  final String name;
  final String activeIcon;
  final String inActiveIcon;
  final int currentIndex;
  final VoidCallback tap;

  const CustomMenuItem(
      {Key? key, required this.index, required this.name, required this.activeIcon, required this.inActiveIcon, required this.currentIndex, required this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: tap,
      child: SizedBox(width: currentIndex == index ? 90 : 50,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                currentIndex == index ? activeIcon : inActiveIcon,
                width: Dimensions.menuIconSize,
                height: Dimensions.menuIconSize,
              ),
              if(currentIndex == index)
                Text(name.tr, maxLines: 1, overflow: TextOverflow.ellipsis,style: textRegular.copyWith(color: Colors.white),)
            ]
        ),
      ),
    );
  }

}