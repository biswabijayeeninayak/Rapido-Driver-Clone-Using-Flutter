import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/trip/model/trip_model.dart';
import 'package:ride_sharing_user_app/view/screens/trip/repository/trip_repo.dart';

class TripController extends GetxController implements GetxService{
  final TripRepo tripRepo;

  TripController({required this.tripRepo});

   bool customerReviewed = false;
  List<TripModel> tripList = [];


   void toggleReviewed(){
     customerReviewed = true;
     update();
   }


   List<String> activityTypeList = ['trips', 'over_view'];
   int activityTypeIndex = 0;
   void setActivityTypeIndex(int index){
     activityTypeIndex = index;
     update();
   }

  void getTripList() async {
    Response response = await tripRepo.getTripList();
    if (response.statusCode == 200) {
      tripList = [];
      tripList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }



}