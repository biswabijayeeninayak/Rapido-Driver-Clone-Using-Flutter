import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';

class WalletRepo{
  final ApiClient apiClient;

  WalletRepo({required this.apiClient});



  Future<Response> getMyEarnList() async {
    List<MyEarnModel> myEarnList = [];
    try {
      myEarnList = [
        MyEarnModel(xID: '74564385', amount: 120,createdAt: '2022-09-14T13:49:51.000000Z',id: 82742),
        MyEarnModel(xID: '74564385', amount: 130,createdAt: '2022-09-14T13:49:51.000000Z',id: 82743),
        MyEarnModel(xID: '74564385', amount: 222,createdAt: '2022-09-14T13:49:51.000000Z',id: 82744),
        MyEarnModel(xID: '74564385', amount: 333,createdAt: '2022-09-14T13:49:51.000000Z',id: 82745),
        MyEarnModel(xID: '74564385', amount: 233,createdAt: '2022-09-14T13:49:51.000000Z',id: 82746),
        MyEarnModel(xID: '74564385', amount: 434,createdAt: '2022-09-14T13:49:51.000000Z',id: 82747),
        MyEarnModel(xID: '74564385', amount: 3445,createdAt: '2022-09-14T13:49:51.000000Z',id: 82748),
        MyEarnModel(xID: '74564385', amount: 4343,createdAt: '2022-09-14T13:49:51.000000Z',id: 82749),


      ];


      Response response = Response(body: myEarnList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }



}