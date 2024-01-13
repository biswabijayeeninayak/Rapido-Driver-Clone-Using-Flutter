import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/notification/model/notification_model.dart';

class NotificationRepo{
  final ApiClient apiClient;

  NotificationRepo({required this.apiClient});

  Future<Response> getNotificationList() async {
    List<NotificationModel> notificationList = [];
    try {
      notificationList = [
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),
        NotificationModel(title: 'Transaction Nike Air Zoom Product', message: 'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',createdAt: '2022-09-14T13:49:51.000000Z'),



      ];


      Response response = Response(body: notificationList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

}