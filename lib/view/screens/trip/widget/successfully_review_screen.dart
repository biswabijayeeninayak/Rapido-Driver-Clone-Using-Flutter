import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/trip/controller/trip_controller.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/header_title_widget.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/not_review_yet.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';


class SuccessfullyReviewedScreen extends StatefulWidget {
  const SuccessfullyReviewedScreen({Key? key}) : super(key: key);

  @override
  State<SuccessfullyReviewedScreen> createState() => _SuccessfullyReviewedScreenState();
}

class _SuccessfullyReviewedScreenState extends State<SuccessfullyReviewedScreen> {
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TripController>(
        builder: (tripController) {
          return Column(children: [
            CustomAppBar(title: 'ratting_and_review'.tr),
            HeaderTitle(title: 'you_just_reviewed_successfully'.tr, color: Theme.of(context).primaryColor,),

            tripController.customerReviewed?
            const NotReviewYet():
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('customer_rate'.tr, style: textSemiBold.copyWith()),
                      Icon(Icons.bookmark_outline_rounded,color: Theme.of(context).hintColor,)
                    ],
                  ),


                  Center(child: GestureDetector(
                    onTap: ()=> tripController.toggleReviewed(),
                      child: SizedBox(width: Dimensions.customerReactionSize,child: Image.asset(Images.customerHappy),))),

                  Text('your_customer_is_satisfied'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge, top: Dimensions.iconSizeDoubleExtraLarge),
                    child: Row(
                      children: [
                        Text('customer_comment'.tr, style: textMedium.copyWith(),),
                      ],
                    ),
                  ),
                  Text('"The Driver was so soft behavior"', style: textMedium.copyWith(color: Theme.of(context).primaryColor),),


                ],),
            )

          ],);
        }
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(height: 90,
          child: CustomButton(buttonText: 'home'.tr, onPressed: (){
            Get.offAll(()=> const DashboardScreen());
          },),),
      ),
    );
  }
}
