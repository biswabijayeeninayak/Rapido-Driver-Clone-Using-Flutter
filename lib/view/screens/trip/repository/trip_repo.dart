import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/trip/model/trip_model.dart';

class TripRepo{
  final ApiClient apiClient;
  TripRepo({required this.apiClient});


  Future<Response> getTripList() async {
    List<TripModel> tripList = [];
    try {
      tripList = [
        

      ];


      Response response = Response(body: tripList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }


}