import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/review/model/review.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';


class ReviewCard extends StatelessWidget {
  final int index;
  final Review review;
  const ReviewCard({Key? key, required this.review, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
      child: Column(children: [
          Container(decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                  blurRadius: 5, spreadRadius: 1)],
            ),
            padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min,children: [

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text('${'order'.tr} # ${review.orderId}', style: textMedium,),
                Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [
                      Padding(padding:  const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.calenderIcon, scale: 2.5,),
                      ),
                      Text(DateConverter.localToIsoString(DateTime.parse(review.createdAt!)),
                        style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeSmall),
                      ),
                    ],
                  ),
                ),
              ],),


               Padding(
                 padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                 child: Row(children: [
                   Container(
                     decoration: BoxDecoration(
                       border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                       borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                     ),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                       child: const CustomImage(image: '',
                         height: 30,width: 30,),
                     ),
                   ),
                   Padding(
                     padding:  const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                     child: Text('${review.customerName}',style: textMedium),
                   ),
                 ],),
               ),


              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ReadMoreText(
                  review.comment!,
                  trimLines: 4,
                  colorClickableText: Theme.of(context).primaryColor,
                  trimMode: TrimMode.Line,
                  textAlign: TextAlign.start,
                  trimCollapsedText: 'show_more'.tr,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                  trimExpandedText: 'show_less'.tr,
                  lessStyle: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :Theme.of(context).primaryColor),
                  moreStyle: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall, color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor),
                ),
              ),
              Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Text('${'rate_your_service'.tr} : '),
                    Icon(Icons.star_rate_rounded, color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor,),
                    Text(review.rating.toString(), style: textMedium.copyWith(),),

                    const Spacer(),
                    GetBuilder<ProfileController>(
                      builder: (profileController) {
                        return GestureDetector(
                          onTap: (){
                            //profileController.savedReview(review.id, review.isSaved == 1 ? 0 : 1, index);
                          },
                          child: Icon(review.isSaved == 1? Icons.bookmark : Icons.bookmark_border,
                            color: review.isSaved == 1? Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :Theme.of(context).primaryColor : Theme.of(context).hintColor),
                        );
                      }
                    ),

                  ],
                ),
              ),




            ],),
          ),
        ],
      ),
    );
  }
}
