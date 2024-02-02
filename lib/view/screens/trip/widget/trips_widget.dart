import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/trip/controller/trip_controller.dart';
import 'package:ride_sharing_user_app/view/screens/trip/model/trip_model.dart';
import 'package:ride_sharing_user_app/view/screens/trip/widget/trip_card.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down_item.dart';
class TripsWidget extends StatelessWidget {
  final TripController tripController;

  const TripsWidget({Key? key, required this.tripController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Your existing code

            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.orderStatusIconHeight),
              child: FutureBuilder<List<TripModel>>(
                future: tripController.getTripList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<TripModel> tripList = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: tripList.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {

                        return TripCard(tripModel: tripList[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


























// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);


ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
    int status;
    String message;
    List<Datum> data;

    ProfileData({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int bookingId;
    int rideId;
    int pilotId;
    int? status;
    dynamic rideStart;
    dynamic rideEnd;
    DateTime createdAt;
    DateTime updatedAt;
    Pilot pilot;
    RiderBookingWithBooking? riderBookingWithBooking;

    Datum({
        required this.id,
        required this.bookingId,
        required this.rideId,
        required this.pilotId,
        required this.status,
        required this.rideStart,
        required this.rideEnd,
        required this.createdAt,
        required this.updatedAt,
        required this.pilot,
        required this.riderBookingWithBooking,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bookingId: json["booking_id"],
        rideId: json["ride_id"],
        pilotId: json["pilot_id"],
        status: json["status"],
        rideStart: json["ride_start"],
        rideEnd: json["ride_end"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pilot: Pilot.fromJson(json["pilot"]),
        riderBookingWithBooking: json["rider_booking_with_booking"] == null ? null : RiderBookingWithBooking.fromJson(json["rider_booking_with_booking"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "ride_id": rideId,
        "pilot_id": pilotId,
        "status": status,
        "ride_start": rideStart,
        "ride_end": rideEnd,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pilot": pilot.toJson(),
        "rider_booking_with_booking": riderBookingWithBooking?.toJson(),
    };
}

class Pilot {
    int id;
    int authId;
    UserName userName;
    DateTime dob;
    Email email;
    Gender gender;
    String mobile;
    Address address;
    Image image;
    Status status;
    String action;
    String currentLat;
    String currentLng;
    DateTime createdAt;
    DateTime updatedAt;

    Pilot({
        required this.id,
        required this.authId,
        required this.userName,
        required this.dob,
        required this.email,
        required this.gender,
        required this.mobile,
        required this.address,
        required this.image,
        required this.status,
        required this.action,
        required this.currentLat,
        required this.currentLng,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Pilot.fromJson(Map<String, dynamic> json) => Pilot(
        id: json["id"],
        authId: json["auth_id"],
        userName: userNameValues.map[json["user_name"]]!,
        dob: DateTime.parse(json["dob"]),
        email: emailValues.map[json["email"]]!,
        gender: genderValues.map[json["gender"]]!,
        mobile: json["mobile"],
        address: addressValues.map[json["address"]]!,
        image: imageValues.map[json["image"]]!,
        status: statusValues.map[json["status"]]!,
        action: json["action"],
        currentLat: json["current_lat"],
        currentLng: json["current_lng"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "auth_id": authId,
        "user_name": userNameValues.reverse[userName],
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "email": emailValues.reverse[email],
        "gender": genderValues.reverse[gender],
        "mobile": mobile,
        "address": addressValues.reverse[address],
        "image": imageValues.reverse[image],
        "status": statusValues.reverse[status],
        "action": action,
        "current_lat": currentLat,
        "current_lng": currentLng,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum Address {
    MUMBAI
}

final addressValues = EnumValues({
    "Mumbai": Address.MUMBAI
});

enum Email {
    SHREYA_GMAIL_COM
}

final emailValues = EnumValues({
    "shreya@gmail.com": Email.SHREYA_GMAIL_COM
});

enum Gender {
    FEMALE
}

final genderValues = EnumValues({
    "female": Gender.FEMALE
});

enum Image {
    THE_1700119710_JPEG
}

final imageValues = EnumValues({
    "1700119710.jpeg": Image.THE_1700119710_JPEG
});

enum Status {
    VERIFIED
}

final statusValues = EnumValues({
    "Verified": Status.VERIFIED
});

enum UserName {
    SHREYA_GHOSHAL
}

final userNameValues = EnumValues({
    "Shreya Ghoshal": UserName.SHREYA_GHOSHAL
});

class RiderBookingWithBooking {
    int id;
    int authId;
    String pickupLocation;
    String dropLocation;
    String? fromState;
    String fromLatitude;
    String fromLongitude;
    String toLatitude;
    String toLongitude;
    BookingType bookingType;
    RideType rideType;
    String? status;
    int? cancelled;
    DateTime createdAt;
    DateTime updatedAt;

    RiderBookingWithBooking({
        required this.id,
        required this.authId,
        required this.pickupLocation,
        required this.dropLocation,
        required this.fromState,
        required this.fromLatitude,
        required this.fromLongitude,
        required this.toLatitude,
        required this.toLongitude,
        required this.bookingType,
        required this.rideType,
        required this.status,
        required this.cancelled,
        required this.createdAt,
        required this.updatedAt,
    });

    factory RiderBookingWithBooking.fromJson(Map<String, dynamic> json) => RiderBookingWithBooking(
        id: json["id"],
        authId: json["auth_id"],
        pickupLocation: json["pickup_location"],
        dropLocation: json["drop_location"],
        fromState: json["from_state"],
        fromLatitude: json["from_latitude"],
        fromLongitude: json["from_longitude"],
        toLatitude: json["to_latitude"],
        toLongitude: json["to_longitude"],
        bookingType: bookingTypeValues.map[json["booking_type"]]!,
        rideType: rideTypeValues.map[json["ride_type"]]!,
        status: json["status"],
        cancelled: json["cancelled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "auth_id": authId,
        "pickup_location": pickupLocation,
        "drop_location": dropLocation,
        "from_state": fromState,
        "from_latitude": fromLatitude,
        "from_longitude": fromLongitude,
        "to_latitude": toLatitude,
        "to_longitude": toLongitude,
        "booking_type": bookingTypeValues.reverse[bookingType],
        "ride_type": rideTypeValues.reverse[rideType],
        "status": status,
        "cancelled": cancelled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum BookingType {
    COURIER,
    RIDE
}

final bookingTypeValues = EnumValues({
    "courier": BookingType.COURIER,
    "ride": BookingType.RIDE
});

enum RideType {
    AUTO,
    BIKE
}

final rideTypeValues = EnumValues({
    "auto": RideType.AUTO,
    "bike": RideType.BIKE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
