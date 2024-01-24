import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widget/notification_card.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drawer.dart';
import 'package:ride_sharing_user_app/view/widgets/type_button_widget.dart';



class ProfileNotificationScreen extends StatelessWidget {
  const ProfileNotificationScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotification();
    return Scaffold(
      body: GetBuilder<NotificationController>(
        builder: (notificationController) {
          return Column(
            children: [
              CustomAppBar(
                title: 'my_notification'.tr,
                showBackButton: true,
                // onTap: () {
                //   Get.to(DashboardScreen());
                // },
              ),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                child: Container(
                  transform: Matrix4.translationValues(0, -25, 0),
                  child: SizedBox(
                    height: Get.find<LocalizationController>().isLtr ? 45 : 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: notificationController.notificationTypeList.length,
                      itemBuilder: (context, index) {
                        return TypeButtonWidget(
                          cardWidth: 110,
                          index: index,
                          name: notificationController.notificationTypeList[index],
                          selectedIndex: notificationController.notificationTypeIndex,
                          onTap: () => notificationController.setNotificationIndex(index),
                        );
                      },
                    ),
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
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notificationData: notificationController.notificationList[index],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
