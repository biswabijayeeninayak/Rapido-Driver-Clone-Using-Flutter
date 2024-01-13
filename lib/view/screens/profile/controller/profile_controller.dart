
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/reward_model.dart';
import 'package:ride_sharing_user_app/view/screens/profile/repository/profile_repo.dart';
import 'package:ride_sharing_user_app/view/widgets/config.dart';

class ProfileController extends GetxController implements GetxService{
  final ProfileRepo profileRepo;

  ProfileController({required this.profileRepo});

  List<RewardModel> rewardList = [];
  List<String> termList = [];

  List<String> profileType = ['my_profile', 'my_vehicle'];

  int _profileTypeIndex = 0;
  int get profileTypeIndex => _profileTypeIndex;

  void setProfileTypeIndex(int index){
    _profileTypeIndex = index;
    update();
  }


  final zoomDrawerController = ZoomDrawerController();
  bool toggle = false;

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    toggle = ! toggle;
    debugPrint("Toggle drawer===>$toggle");
    update();
  }



  int _offerSelectedIndex = 0;
  int get offerSelectedIndex => _offerSelectedIndex;

  void setOfferTypeIndex(int index){
    _offerSelectedIndex = index;
    update();
  }



  void getRewardList() async {
    Response response = await profileRepo.getRewardList();
    if (response.statusCode == 200) {
      rewardList = [];
      rewardList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getTermList() async {
    Response response = await profileRepo.getTermList();
    if (response.statusCode == 200) {
      termList = [];
      termList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }




}