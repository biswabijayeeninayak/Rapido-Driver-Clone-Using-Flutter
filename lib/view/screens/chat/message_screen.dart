import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/chat/controller/chat_controller.dart';
import 'package:ride_sharing_user_app/view/screens/chat/widget/message_bubble.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<ChatController>(builder: (messageController){
      return Column(
        children: [
          CustomAppBar(title: 'message'.tr),


          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              itemCount: 20,
              reverse: true,
              itemBuilder: (context, index) {
                return ConversationBubble(
                  isRightMessage: Random().nextBool(),
                );
              },
            ),
          ),


          messageController.pickedImageFile != null && messageController.pickedImageFile!.isNotEmpty ?
          Container(height: 90, width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return  Stack(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(height: 80, width: 80,
                          child: Image.file(
                            File(messageController.pickedImageFile![index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      child: InkWell(
                        child: const Icon(Icons.cancel_outlined, color: Colors.red),
                        onTap: () => messageController.pickMultipleImage(true,index: index),
                      ),
                    ),
                  ],
                );},
              itemCount: messageController.pickedImageFile!.length,
            ),
          ) : const SizedBox(),

          messageController.otherFile != null ?
          Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 25,
              child: Text(
                messageController.otherFile!.names.toString(),
              ),
            ),
            Positioned(top: 0, right: 0,
                child: InkWell(child: const Icon(Icons.cancel_outlined,
                    color: Colors.red),
                    onTap: () => messageController.pickOtherFile(true)
                )
            )
          ],) : const SizedBox(),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
                bottom: Dimensions.paddingSizeExtraLarge,
              ),
              decoration: BoxDecoration(

                boxShadow:  [
                  BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(.25), blurRadius: 2.0, spreadRadius: 5, offset: const Offset(5, 4),
                  ),
                ], color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(100),),
              ),
              child: Form(
                key: messageController.conversationKey,
                child: Row(
                  children: [
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: TextField(
                        controller: messageController.conversationController,
                        textCapitalization: TextCapitalization.sentences,
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "type_here".tr,
                          hintStyle: textRegular.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (String newText) {

                        },
                      ),
                    ),

                    Row(
                      children: [
                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: InkWell(child: Image.asset(
                              Images.pickImage, color: Get.isDarkMode?Colors.white:Colors.black),
                              onTap: () => messageController.pickMultipleImage(false)
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSeven),
                          child: InkWell(child: Image.asset(Images.pickFile, color: Get.isDarkMode?Colors.white:Colors.black),
                              onTap: () => messageController.pickOtherFile(false)
                          ),
                        ),

                        messageController.isLoading! ?
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 20,
                          width: 40,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).hoverColor,
                            ),
                          ),
                        ) :InkWell(
                          onTap: (){
                            if(messageController.conversationController.text.isEmpty
                                && messageController.pickedImageFile!.isEmpty
                                && messageController.otherFile==null){
                            }
                            // else if(messageController.conversationKey.currentState!.validate()){
                            //   messageController.sendMessage(widget.channelID);
                            // }
                            messageController.conversationController.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                            ),
                            child: Image.asset(
                              Images.sendMessage,
                              width: Dimensions.iconSizeMedium,
                              height: Dimensions.iconSizeMedium,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      );
    }),
    );
  }
}
