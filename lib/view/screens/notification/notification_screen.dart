import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widget/notification_card.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drawer.dart';
import 'package:ride_sharing_user_app/view/widgets/type_button_widget.dart';


class NotificationMenu extends GetView<ProfileController> {
  const NotificationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: const ProfileMenuScreen(),
        mainScreen: const NotificationScreen(),
        borderRadius: 24.0,
        angle: -5.0,
        isRtl: !Get.find<LocalizationController>().isLtr,
        menuBackgroundColor: Theme.of(context).primaryColor,
        slideWidth: MediaQuery.of(context).size.width * 0.85,
        mainScreenScale: .4,
      ),
    );
  }
}



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotificationList();
    return Scaffold(
      body: GetBuilder<NotificationController>(
        builder: (notificationController) {
          return Column(children: [
            CustomAppBar(title: 'my_notification'.tr, showBackButton: false,  onTap: (){
              Get.find<ProfileController>().toggleDrawer();
            }),

            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              child: Container(transform: Matrix4.translationValues(0, -25, 0),
                child: SizedBox(height: Get.find<LocalizationController>().isLtr? 45 : 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: notificationController.notificationTypeList.length,
                      itemBuilder: (context, index){
                        return TypeButtonWidget(
                          cardWidth: 110,
                          index: index,name: notificationController.notificationTypeList[index],selectedIndex: notificationController.notificationTypeIndex,
                          onTap: ()=> notificationController.setNotificationIndex(index),
                        );
                      }),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.orderStatusIconHeight),
                child: ListView.builder(
                    itemCount: notificationController.notificationList.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return NotificationCard(notificationModel: notificationController.notificationList[index]);
                    }),
              ),
            )
          ],);
        }
      ),
    );
  }
}
