import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/profile/model/reward_model.dart';

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});



  Future<Response> getRewardList() async {
    List<RewardModel> rewardList=[];
    try {
      rewardList = [
        RewardModel(
          title: 'Complete 5 Trip Get', amount: 120,
          image: Images.reward1, step: true, targetStep: 5, filUpStep: 3, todayTargetAmount: 1000, todayTargetFilUpAmount: 710, todayTargetPoint: 200
        ),

        RewardModel(
            title: 'Earn \$1000 Today Get Point', amount: 200,
            image: Images.reward2, step: false, targetStep: 5, filUpStep: 3, todayTargetAmount: 1000, todayTargetFilUpAmount: 710, todayTargetPoint: 200
        ),

        RewardModel(
            title: 'Earn \$1000 Today Get Point', amount: 200,
            image: Images.reward2, step: false, targetStep: 5, filUpStep: 3, todayTargetAmount: 1000, todayTargetFilUpAmount: 710, todayTargetPoint: 200
        ),


      ];


      Response response = Response(body: rewardList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }
  Future<Response> getTermList() async {
    List<String> termList=[];
    try {
      termList = [
        'Your access and use of the hexa ride service',
        'Your access and use of the hexa ride service',
        'Your access and use of the hexa ride service',
        'Your access and use of the hexa ride service',
        ];


      Response response = Response(body: termList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

}