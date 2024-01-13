
import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ConversationBubble extends StatefulWidget {
  final bool isRightMessage;

  const ConversationBubble({super.key, required this.isRightMessage});

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {
  @override
  Widget build(BuildContext context) {


    return Column(crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
      Padding(padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(20, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 20, 5),
        child: Column(
          crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(widget.isRightMessage ?
                "admin" :"Customer",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            ),
            SizedBox(height:Dimensions.fontSizeExtraSmall),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                widget.isRightMessage ?
                const SizedBox() :
                Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: const CustomImage(
                        height: 30,
                        width: 30,
                        image: '',
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Flexible(
                  child: Column(crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.isRightMessage?Theme.of(context).colorScheme.onPrimaryContainer:Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Text('I Have purchased some products from this website, my orders are showing places successfully but I cannot find my orders in the order history'),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(width: 10,),
                widget.isRightMessage ?
                ClipRRect(borderRadius: BorderRadius.circular(50),
                    child: const CustomImage(height: 30, width: 30,
                        image: ''
                    )
                )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),

      Padding(
          padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 0, 50, 5) : const EdgeInsets.fromLTRB(50, 0, 5, 5),
          child: Text(
              "Dec 12,2023",
              textDirection: TextDirection.ltr,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)
          )
      ),
    ],
    );
  }
}


