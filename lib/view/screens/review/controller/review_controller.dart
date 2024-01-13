import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/review/model/review.dart';
import 'package:ride_sharing_user_app/view/screens/review/repository/review_repo.dart';

class ReviewController extends GetxController implements GetxService{
  final ReviewRepo reviewRepo;

  ReviewController({required this.reviewRepo});

  int _reviewTypeIndex = 0;
  int get reviewTypeIndex => _reviewTypeIndex;

  List<String> reviewTypeList =['reviews', 'saved'];
  List<Review> reviewList=[];

  void setReviewIndex(int index){
    _reviewTypeIndex = index;
    if(index == 0){
      getReviewList();
    }else{
      getSavedReviewList();
    }
    update();
  }

  void getReviewList() async {
    Response response = await reviewRepo.getReviewList();
    if (response.statusCode == 200) {
      reviewList = [];
      reviewList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  void getSavedReviewList() async {
    Response response = await reviewRepo.getSavedReviewList();
    if (response.statusCode == 200) {
      reviewList = [];
      reviewList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


}