import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/notification/model/notification_model.dart';
import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService{
  final NotificationRepo notificationRepo;

  NotificationController({required this.notificationRepo});


  List<String> notificationTypeList = ['activity', 'offer', 'news'];
  int _notificationTypeIndex = 0;
  int get notificationTypeIndex => _notificationTypeIndex;
  List<NotificationModel> notificationList = [];

  void setNotificationIndex(int index){
    _notificationTypeIndex = index;
    update();
  }


  void getNotificationList() async {
    Response response = await notificationRepo.getNotificationList();
    if (response.statusCode == 200) {
      notificationList = [];
      notificationList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


}