// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/data/api_checker.dart';
// import 'package:ride_sharing_user_app/util/constant.dart';
// import 'package:ride_sharing_user_app/view/screens/notification/model/notification_model.dart';
// import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class NotificationController extends GetxController implements GetxService {
//   final NotificationRepo notificationRepo;

//   NotificationController({required this.notificationRepo});
//   List<NotificationModel>? _notificationList = [];

//   // List<String> notificationTypeList = ['activity', 'offer', 'news'];
//   List<String> notificationTypeList = ['activity'];

//   int _notificationTypeIndex = 0;
//   int get notificationTypeIndex => _notificationTypeIndex;
//   List<NotificationModel> notificationList = [];

//   void setNotificationIndex(int index) {
//     _notificationTypeIndex = index;
//     update();
//   }

//   Future<void> getNotification() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String id = prefs.getString('userId').toString();
//     print(id);
//     String token = prefs.getString('token').toString();

//     try {
//       var response = await http.get(
//         Uri.parse('http://kods.tech/munsride/api/pilot_notification/$id'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);

//         final List<dynamic> notificationsList =
//             (jsonResponse["data"]as List);

//         _notificationList = notificationsList
//             .map((notificationData) =>
//                 NotificationModel.fromJson(notificationData))
//             .toList();

//         print(response.body);
//       } else {
//         print('Failed with status: ${response.statusCode}');
//         print('Reason: ${response.reasonPhrase}');
//       }
//     } catch (error) {
//       print('Error fetching notifications: $error');
//     }
//     update();
//   }
// }


import 'dart:convert';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/notification/model/notification_model.dart';
import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;

  NotificationController({required this.notificationRepo});

  List<Datum> _notificationList = [];

  int _notificationTypeIndex = 0;
  int get notificationTypeIndex => _notificationTypeIndex;

    List<Datum> get notificationList => _notificationList ?? [];

  List<String> get notificationTypeList => ['activity'];

  void setNotificationIndex(int index) {
    _notificationTypeIndex = index;
    update();
  }

  Future<void> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId').toString();
    print(id);
    String token = prefs.getString('token').toString();

    try {
      var response = await http.get(
        Uri.parse('http://kods.tech/munsride/api/pilot_notification/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("data")) {
          _notificationList = (jsonResponse["data"] as List)
              .map((notificationData) => Datum.fromJson(notificationData))
              .toList();
        } else {
          print('Data key not found in the response');
        }
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Reason: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching notifications: $error');
    }
    update();
  }
}
