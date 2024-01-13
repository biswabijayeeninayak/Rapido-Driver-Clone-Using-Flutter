

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/my_activity_model.dart';
import 'package:ride_sharing_user_app/view/screens/hour_of_service/model/service_hour_model.dart';
import 'package:ride_sharing_user_app/view/screens/ride/model/ride_request_model.dart';

class RideRepo{
  ApiClient apiClient;
  RideRepo({required this.apiClient});



  Future<Response> getMyActivityList() async {
    List<MyActivityModel> activityList=[];
    try {
      activityList = [
        MyActivityModel(Theme.of(Get.context!).colorScheme.tertiary, 'active', '02:26 hr', Images.activeHourIcon),
        MyActivityModel(Theme.of(Get.context!).colorScheme.secondary, 'on_driving', '05:26 hr', Images.onDrivingHourIcon),
        MyActivityModel(Theme.of(Get.context!).colorScheme.tertiaryContainer, 'idle_time', '05:26 hr', Images.idleHourIcon),
        MyActivityModel(Theme.of(Get.context!).colorScheme.secondaryContainer, 'offline', '05:26 hr', Images.offlineHourIcon),

        ];


      Response response = Response(body: activityList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

  Future<Response> totalHourActivityList() async {
    List<ServiceHourModel> serviceHourList=[];
    try {
      serviceHourList = [
        ServiceHourModel('Time Squire Marvel, Street 6H, New York.','2023-01-11T05:35:51.000000Z','30'),
        ServiceHourModel('Time Squire Marvel, Street 6H, New York.','2023-01-11T05:35:51.000000Z','30'),
        ServiceHourModel('Time Squire Marvel, Street 6H, New York.','2023-01-11T05:35:51.000000Z','30'),
        ServiceHourModel('Time Squire Marvel, Street 6H, New York.','2023-01-11T05:35:51.000000Z','30'),
      ];


      Response response = Response(body: serviceHourList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }


  Future<Response> getRideRequestList() async {
    List<RideRequestModel> rideRequestList=[];
    try {
      rideRequestList = [
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
        customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
            customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
            customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
            customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
            customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),
        RideRequestModel(from: '52 Bedok Reservoir Cres Singapore 479226', to: 'Bidadari Park Drive Singapore - 1 Wallich St Singapore', route1: 'Cres road, 52 Bedok Reservoir Cres Singapore 479226 ', route2: 'Ditij road, 52 Bedok Reservoir Cres Singapore 479226',pickupTime: '11.34 am',
            customer: Customer(name: 'Jane Cooper', image: '',ratting: '5', fair: '230')),


      ];


      Response response = Response(body: rideRequestList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }


}