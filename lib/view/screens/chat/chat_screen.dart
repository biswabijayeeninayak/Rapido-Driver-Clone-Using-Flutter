
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/chat/controller/chat_controller.dart';
import 'package:ride_sharing_user_app/view/screens/chat/widget/message_item.dart';
import 'package:ride_sharing_user_app/view/screens/chat/widget/user_type_button_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder: (chatController) {
          return Column(children: [
            CustomAppBar(title: 'message'.tr,),
            Container(transform: Matrix4.translationValues(0, -25, 0),
              child: SizedBox(height: Dimensions.headerCardHeight,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: chatController.userType.length,
                    itemBuilder: (context, index){
                      return UserTypeButtonWidget(userType : chatController.userType[index], index: index);
                    }),
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                return  MessageItem(
                  isRead: Random().nextBool(),
                );
              },
                itemCount: 10,
                padding: const EdgeInsets.all(0),
              ),
            ),

          ],);
        }
      ),
    );
  }
}
