import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/trip/model/trip_model.dart';
import 'package:ride_sharing_user_app/view/screens/trip/trip_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class TripCard extends StatelessWidget {
  final TripModel tripModel;

  const TripCard({Key? key, required this.tripModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const TripDetails()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            Dimensions.paddingSizeDefault,
            0,
            Dimensions.paddingSizeDefault,
            Dimensions.paddingSizeDefault),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context)
                        .hintColor
                        .withOpacity(.20),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(1, 1))
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Images.mapSample),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .hintColor
                              .withOpacity(.15),
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraSmall)),
                      height: Dimensions.orderStatusIconHeight,
                      width: Dimensions.orderStatusIconHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.bike),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tripModel.riderBooking?.pickupLocation ?? '',
                            style: textMedium,
                          ),
                          // Text(
                          //   DateConverter.isoStringToDateTimeString(
                          //       tripModel.riderBooking?.bookingCreatedAt ?? ''),
                          //   style: textRegular.copyWith(
                          //     color: Theme.of(context)
                          //         .hintColor
                          //         .withOpacity(.85),
                          //     fontSize: Dimensions.fontSizeSmall,
                          //   ),
                          // ),
                          // Text(
                          //   '${'total'.tr} ${PriceConverter.convertPrice(context, tripModel.amount ?? 0.0)}',
                          // ),
                        ],
                      ),
                    ),
                    ElevatedButton(onPressed: (){

                      print( tripModel.riderBooking?.pickupLocation);
                    }, child: Container()),
                    SizedBox(
                      width: Dimensions.iconSizeSmall,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context)
                            .hintColor
                            .withOpacity(.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Future<List<Map<String, dynamic>>> fetchRideDetails() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String id = prefs.getString('userId').toString();
  //   print(id);
  //   final String apiUrl = "http://kods.tech/munsride/api/pilot_rides/$id'";

  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonResponse = json.decode(response.body);

  //       if (jsonResponse['status'] == 200) {
  //         List<Map<String, dynamic>> rideDetails = [];

  //         for (var rideData in jsonResponse['data']) {
  //           var pilotData = rideData['pilot'];
  //           var riderBookingData = rideData['rider_booking_with_booking'];

  //           rideDetails.add({
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

  //         return rideDetails;
  //       } else {
  //         // Handle API error
  //         throw Exception(jsonResponse['message']);
  //       }
  //     } else {
  //       // Handle HTTP error
  //       throw Exception('Failed to load ride details');
  //     }
  //   } catch (error) {
  //     // Handle other errors
  //     throw Exception('Error: $error');
  //   }
  // }
}
