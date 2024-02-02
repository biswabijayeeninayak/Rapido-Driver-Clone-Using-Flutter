import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/trip/model/trip_model.dart';
import 'package:ride_sharing_user_app/view/screens/trip/repository/trip_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripController extends GetxController implements GetxService{
  final TripRepo tripRepo;

  TripController({required this.tripRepo});

   bool customerReviewed = false;
  List<TripModel> tripList = [];


   void toggleReviewed(){
     customerReviewed = true;
     update();
   }


  //  List<String> activityTypeList = ['trips', 'over_view'];
   List<String> activityTypeList = ['trips'];

   int activityTypeIndex = 0;
   void setActivityTypeIndex(int index){
     activityTypeIndex = index;
     update();
   }

  // void getTripList() async {
  //   Response response = await tripRepo.getTripList();
  //   if (response.statusCode == 200) {
  //     tripList = [];
  //     tripList.addAll(response.body);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

// Future<List<Map<String, dynamic>>> getTripList() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String id = prefs.getString('userId').toString();
//     final String apiUrl = "http://kods.tech/munsride/api/pilot_rides/$id";

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);

//       if (jsonResponse['status'] == 200) {
//         List<Map<String, dynamic>> tripList = [];

//         for (var rideData in jsonResponse['data']) {
//           var pilotData = rideData['pilot'];
//           var riderBookingData = rideData['rider_booking_with_booking'];

//           tripList.add({
//             'id': rideData['id'],
//             'booking_id': rideData['booking_id'],
//             'ride_id': rideData['ride_id'],
//             'pilot_id': rideData['pilot_id'],
//             'status': rideData['status'],
//             'ride_start': rideData['ride_start'],
//             'ride_end': rideData['ride_end'],
//             'created_at': rideData['created_at'],
//             'updated_at': rideData['updated_at'],
//             'pilot': {
//               'pilot_id': pilotData['id'],
//               'user_name': pilotData['user_name'],
//               'dob': pilotData['dob'],
//               'email': pilotData['email'],
//               'gender': pilotData['gender'],
//               'mobile': pilotData['mobile'],
//               'address': pilotData['address'],
//               'image': pilotData['image'],
//               'status': pilotData['status'],
//               'action': pilotData['action'],
//               'current_lat': pilotData['current_lat'],
//               'current_lng': pilotData['current_lng'],
//               'created_at': pilotData['created_at'],
//               'updated_at': pilotData['updated_at'],
//             },
//             'rider_booking_with_booking': {
//               'booking_id': riderBookingData['id'],
//               'auth_id': riderBookingData['auth_id'],
//               'pickup_location': riderBookingData['pickup_location'],
//               'drop_location': riderBookingData['drop_location'],
//               'from_state': riderBookingData['from_state'],
//               'from_latitude': riderBookingData['from_latitude'],
//               'from_longitude': riderBookingData['from_longitude'],
//               'to_latitude': riderBookingData['to_latitude'],
//               'to_longitude': riderBookingData['to_longitude'],
//               'booking_type': riderBookingData['booking_type'],
//               'ride_type': riderBookingData['ride_type'],
//               'status': riderBookingData['status'],
//               'cancelled': riderBookingData['cancelled'],
//               'created_at': riderBookingData['created_at'],
//               'updated_at': riderBookingData['updated_at'],
//             },
//           });
//         }

//         return tripList;
//       } else {
//         // Handle API error
//         throw Exception(jsonResponse['message']);
//       }
//     } else {
//       // Handle HTTP error
//       throw Exception('Failed to load trip list');
//     }
//   } catch (error) {
//     // Handle other errors
//     throw Exception('Error: $error');
//   }
// }


Future<List<TripModel>> getTripList() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId').toString();
    final String apiUrl = "http://kods.tech/munsride/api/pilot_rides/$id";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == 200) {
        List<TripModel> tripList = [];

        for (var rideData in jsonResponse['data']) {
          var pilotData = rideData['pilot'];
          var riderBookingData = rideData['rider_booking_with_booking'];

          tripList.add(TripModel(
            id: rideData['id'].toString(),
            bookingId: rideData['booking_id'].toString(),
            rideId: rideData['ride_id'].toString(),
            pilotId: rideData['pilot_id'].toString(),
            status: rideData['status'].toString(),
            rideStart: rideData['ride_start'].toString(),
            rideEnd: rideData['ride_end'].toString(),
            createdAt: rideData['created_at'].toString(),
            updatedAt: rideData['updated_at'].toString(),
            pilot: PilotModel(
              // Populate pilot model fields
            ),
            riderBooking: RiderBookingModel(
              // Populate rider booking model fields
            ),
          ));
        }
        print("===============");
print(tripList);
        return tripList;
      } else {
        // Handle API error
        throw Exception(jsonResponse['message']);
      }
    } else {
      // Handle HTTP error
      throw Exception('Failed to load trip list');
    }
  } catch (error) {
    // Handle other errors
    throw Exception('Error: $error');
  }
}

}