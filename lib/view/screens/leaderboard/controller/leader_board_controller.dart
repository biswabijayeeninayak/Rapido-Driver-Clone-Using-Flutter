import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/model/leaderboard_model.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/repository/leader_board_repo.dart';

class LeaderBoardController extends GetxController implements GetxService{
  final LeaderBoardRepo leaderBoardRepo;

  LeaderBoardController({required this.leaderBoardRepo});

  List<LeaderBoard> leaderBoardList=[];


  void getLeaderBoardList() async {
    Response response = await leaderBoardRepo.getRewardList();
    if (response.statusCode == 200) {
      leaderBoardList = [];
      leaderBoardList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}