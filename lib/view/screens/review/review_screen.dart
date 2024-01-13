import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/review/controller/review_controller.dart';
import 'package:ride_sharing_user_app/view/screens/review/widget/review_card.dart';
import 'package:ride_sharing_user_app/view/screens/review/widget/review_type_button_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  @override
  void initState() {
    Get.find<ReviewController>().getReviewList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReviewController>(
        builder: (reviewController) {
          return Column(children: [
            CustomAppBar(title: 'reviews'.tr),

            Container(transform: Matrix4.translationValues(0, -25, 0),
              child: SizedBox(height: Dimensions.headerCardHeight,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: reviewController.reviewTypeList.length,
                    itemBuilder: (context, index){
                      return ReviewTypeButtonWidget(reviewType : reviewController.reviewTypeList[index], index: index);
                    }),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemBuilder: (context,index){
                return  ReviewCard(review: reviewController.reviewList[index], index: index);
              },
                itemCount: reviewController.reviewList.length,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ],);
        }
      ),
    );
  }
}
