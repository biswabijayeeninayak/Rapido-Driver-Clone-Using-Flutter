class TripModel {
  String? id;
  String? bookingId;
  String? rideId;
  String? pilotId;
  String? status;
  String? rideStart;
  String? rideEnd;
  String? createdAt;
  String? updatedAt;

  PilotModel? pilot;
  RiderBookingModel? riderBooking;

  TripModel({
    this.id,
    this.bookingId,
    this.rideId,
    this.pilotId,
    this.status,
    this.rideStart,
    this.rideEnd,
    this.createdAt,
    this.updatedAt,
    this.pilot,
    this.riderBooking,
  });
}

class PilotModel {
  String? pilotId;
  String? userName;
  String? dob;
  String? email;
  String? gender;
  String? mobile;
  String? address;
  String? image;
  String? status;
  String? action;
  String? currentLat;
  String? currentLng;
  String? pilotCreatedAt;
  String? pilotUpdatedAt;

  PilotModel({
    this.pilotId,
    this.userName,
    this.dob,
    this.email,
    this.gender,
    this.mobile,
    this.address,
    this.image,
    this.status,
    this.action,
    this.currentLat,
    this.currentLng,
    this.pilotCreatedAt,
    this.pilotUpdatedAt,
  });
}

class RiderBookingModel {
  String? bookingId;
  String? authId;
  String? pickupLocation;
  String? dropLocation;
  String? fromState;
  String? fromLatitude;
  String? fromLongitude;
  String? toLatitude;
  String? toLongitude;
  String? bookingType;
  String? rideType;
  String? bookingStatus;
  String? isCancelled;
  String? bookingCreatedAt;
  String? bookingUpdatedAt;

  RiderBookingModel({
    this.bookingId,
    this.authId,
    this.pickupLocation,
    this.dropLocation,
    this.fromState,
    this.fromLatitude,
    this.fromLongitude,
    this.toLatitude,
    this.toLongitude,
    this.bookingType,
    this.rideType,
    this.bookingStatus,
    this.isCancelled,
    this.bookingCreatedAt,
    this.bookingUpdatedAt,
  });
}



