import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/header_title_widget.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/successfully_review_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';


class ReviewThisCustomerScreen extends StatefulWidget {
  const ReviewThisCustomerScreen({Key? key}) : super(key: key);

  @override
  State<ReviewThisCustomerScreen> createState() => _ReviewThisCustomerScreenState();
}

class _ReviewThisCustomerScreenState extends State<ReviewThisCustomerScreen> {
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: 'ratting_and_review'.tr,),
        HeaderTitle(title: 'payment_received_successfully'.tr, color: Theme.of(context).primaryColor,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('review'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text('rate_this_customer'.tr, style: textRegular.copyWith(),),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: Dimensions.iconSizeLarge,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    debugPrint(rating.toString());
                  },
                ),
              ],
            ),

              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: Dimensions.paddingSizeSmall),
                child: Text('leave_him_a_comment'.tr, style: textRegular.copyWith(),),
              ),
              TextFormField(
                controller: reviewController,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).hintColor.withOpacity(.1),
                  hintText: 'your_feedback'.tr,
                  hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    borderSide:  BorderSide(width: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    borderSide:  BorderSide(width: 0.5,
                        color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  ),


                ),

              ),
          ],),
        )

      ],),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SizedBox(height: 90,
          child: Column(children: [
            Text('skip_for_now'.tr,
              style: textRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline),),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CustomButton(buttonText: 'submit'.tr, onPressed: (){
              Get.to(()=> const SuccessfullyReviewedScreen());
            },)
        ],),),
      ),
    );
  }
}
