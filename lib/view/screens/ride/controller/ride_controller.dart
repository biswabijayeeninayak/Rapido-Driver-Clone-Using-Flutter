
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/my_activity_model.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/model/service_hour_model.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/ride_request_model.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';

class RideController extends GetxController implements GetxService{
  final RideRepo rideRepo;
  RideController({required this.rideRepo});




  int _orderStatusSelectedIndex = 0;
  int get orderStatusSelectedIndex => _orderStatusSelectedIndex;

  int _hourActivityIndex = 0;
  int get hourActivityIndex => _hourActivityIndex;

  List<MyActivityModel> activityList=[];
  List<ServiceHourModel> serviceHourList=[];
  List<RideRequestModel> rideRequestList=[];



  String _activityName = 'active';
  String get activityName => _activityName;


  void setOrderStatusTypeIndex(int index){
    _orderStatusSelectedIndex = index;
    update();
  }


  void setHourActivityIndex(int index){
    _hourActivityIndex = index;
    if(index == 0){
      _activityName = 'active';
    }else if(index == 1){
      _activityName = 'driving';
    }else if(index == 2){
      _activityName = 'idle';
    }else if(index == 3){
      _activityName = 'offline';
    }
    update();
  }

  void getMyActivityList() async {
    Response response = await rideRepo.getMyActivityList();
    if (response.statusCode == 200) {
      activityList = [];
      activityList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  bool isFinalBid = false;
  void toggleFinalBid(){
    isFinalBid = true;
    update();
  }


  bool bidAccepted = false;
  void toggleBidAccepted(){
    bidAccepted = !bidAccepted;
    update();
  }

  String yourState = '';
  void setYourCurrentState(String state){
    yourState = state;

    update();
  }



  void totalHourActivityList() async {
    Response response = await rideRepo.totalHourActivityList();
    if (response.statusCode == 200) {
      serviceHourList = [];
      serviceHourList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getRideRequestList() async {
    Response response = await rideRepo.getRideRequestList();
    if (response.statusCode == 200) {
      rideRequestList = [];
      rideRequestList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }




}