import 'dart:convert';

ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
    int status;
    String message;
    Data data;

    ProfileData({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
  Pilot pilot;
  int days;
  double? avgrating; // Make avgrating nullable

  Data({
    required this.pilot,
    required this.days,
    required this.avgrating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pilot: Pilot.fromJson(json["pilot"]),
    days: json["days"],
    avgrating: json["avgrating"]?.toDouble(), // Convert to double if not null
  );
    Map<String, dynamic> toJson() => {
        "pilot": pilot.toJson(),
        "days": days,
        "avgrating": avgrating,
    };
}

class Pilot {
    int id;
    int authId;
    String userName;
    DateTime dob;
    String email;
    String gender;
    String mobile;
    String address;
    String image;
    String status;
    String action;
    String currentLat;
    String currentLng;
    DateTime createdAt;
    DateTime updatedAt;
    double? avgrating;
    List<AssignedRide> assignedRides;
    Auth auth;

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
        required this.assignedRides,
        required this.auth,
    });

    factory Pilot.fromJson(Map<String, dynamic> json) => Pilot(
        id: json["id"],
        authId: json["auth_id"],
        userName: json["user_name"],
        dob: DateTime.parse(json["dob"]),
        email: json["email"],
        gender: json["gender"],
        mobile: json["mobile"],
        address: json["address"],
        image: json["image"],
        status: json["status"],
        action: json["action"],
        currentLat: json["current_lat"],
        currentLng: json["current_lng"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        assignedRides: List<AssignedRide>.from(json["assigned_rides"].map((x) => AssignedRide.fromJson(x))),
        auth: Auth.fromJson(json["auth"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "auth_id": authId,
        "user_name": userName,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "email": email,
        "gender": gender,
        "mobile": mobile,
        "address": address,
        "image": image,
        "status": status,
        "action": action,
        "current_lat": currentLat,
        "current_lng": currentLng,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "assigned_rides": List<dynamic>.from(assignedRides.map((x) => x.toJson())),
        "auth": auth.toJson(),
    };
}

class AssignedRide {
    int id;
    int bookingId;
    int rideId;
    int pilotId;
    int? status;
    dynamic rideStart;
    dynamic rideEnd;
    DateTime createdAt;
    DateTime updatedAt;
    RiderBooking? riderBooking;

    AssignedRide({
        required this.id,
        required this.bookingId,
        required this.rideId,
        required this.pilotId,
        required this.status,
        required this.rideStart,
        required this.rideEnd,
        required this.createdAt,
        required this.updatedAt,
        required this.riderBooking,
    });

    factory AssignedRide.fromJson(Map<String, dynamic> json) => AssignedRide(
        id: json["id"],
        bookingId: json["booking_id"],
        rideId: json["ride_id"],
        pilotId: json["pilot_id"],
        status: json["status"],
        rideStart: json["ride_start"],
        rideEnd: json["ride_end"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
       riderBooking: json["rider_booking"] == null
      ? null
      : RiderBooking.fromJson(json["rider_booking"] as Map<String, dynamic>),
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
        "rider_booking": riderBooking?.toJson(),
    };
}

class RiderBooking {
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
    Status? status;
    int? cancelled;
    DateTime createdAt;
    DateTime updatedAt;

    RiderBooking({
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

    factory RiderBooking.fromJson(Map<String, dynamic> json) => RiderBooking(
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
        status: statusValues.map[json["status"]]!,
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
        "status": statusValues.reverse[status],
        "cancelled": cancelled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum BookingType {
    RIDE
}

final bookingTypeValues = EnumValues({
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

enum Status {
    COMPLETED
}

final statusValues = EnumValues({
    "completed": Status.COMPLETED
});

class Auth {
    int id;
    String userType;
    String userName;
    String email;
    int phone;
    String password;
    dynamic image;
    String fromState;
    String city;
    DateTime createdAt;
    DateTime updatedAt;

    Auth({
        required this.id,
        required this.userType,
        required this.userName,
        required this.email,
        required this.phone,
        required this.password,
        required this.image,
        required this.fromState,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        id: json["id"],
        userType: json["user_type"],
        userName: json["user_name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        image: json["image"],
        fromState: json["from_state"],
        city: json["city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_type": userType,
        "user_name": userName,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image,
        "from_state": fromState,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
