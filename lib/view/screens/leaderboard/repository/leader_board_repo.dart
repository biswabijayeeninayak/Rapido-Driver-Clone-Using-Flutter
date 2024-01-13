import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/leaderboard/model/leaderboard_model.dart';

class LeaderBoardRepo{
  final ApiClient apiClient;

  LeaderBoardRepo({required this.apiClient});


  Future<Response> getRewardList() async {
    List<LeaderBoard> leaderBoardList=[];
    try {
      leaderBoardList = [
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Dianel Russel',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Ronald Richards',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Annette Black',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),
        LeaderBoard(image: '', name: 'Courtney Henrey',amount: 2323, tripNumber: 7),

      ];


      Response response = Response(body: leaderBoardList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }


}