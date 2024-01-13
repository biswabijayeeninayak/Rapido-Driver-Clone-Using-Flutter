class VehicleDetails {
  final int status;
  final VehicleData data;
  final String message;

  VehicleDetails({
    required this.status,
    required this.data,
    required this.message,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      status: json['status'],
      data: VehicleData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class VehicleData {
  final int id;
  final int authId;
  final String vehicleType;
  final String vehicleNumber;
  final int vehicleModelYear;
  final String modelName;
  final String? vehicleImgFront;
  final String? vehicleImageBack;
  final String? vehicleStatus;
  final String? vehicleRejectReason;
  final String? govtIdNumber;
  final String? govtIdFrontImg;
  final String? govtIdBackImg;
  final String? govtIdStatus;
  final String? govtIdRejectReason;
  final String? rcNumber;
  final String? rcImgFront;
  final String? rcImgBack;
  final String? rcStatus;
  final String? rcRejectReason;
  final String? dlNumber;
  final String? dlImgFront;
  final String? dlImgBack;
  final String? dlStatus;
  final String? dlRejectReason;
  final String? bankAccountNumber;
  final String? bankImgFront;
  final String? bankImgBack;
  final String? bankStatus;
  final String? bankRejectReason;
  final String createdAt;
  final String updatedAt;

  VehicleData({
    required this.id,
    required this.authId,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleModelYear,
    required this.modelName,
    this.vehicleImgFront,
    this.vehicleImageBack,
    this.vehicleStatus,
    this.vehicleRejectReason,
    this.govtIdNumber,
    this.govtIdFrontImg,
    this.govtIdBackImg,
    this.govtIdStatus,
    this.govtIdRejectReason,
    this.rcNumber,
    this.rcImgFront,
    this.rcImgBack,
    this.rcStatus,
    this.rcRejectReason,
    this.dlNumber,
    this.dlImgFront,
    this.dlImgBack,
    this.dlStatus,
    this.dlRejectReason,
    this.bankAccountNumber,
    this.bankImgFront,
    this.bankImgBack,
    this.bankStatus,
    this.bankRejectReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      id: json['id'],
      authId: json['auth_id'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      vehicleModelYear: json['vehicle_model_year'],
      modelName: json['model_name'],
      vehicleImgFront: json['vehicle_img_front'],
      vehicleImageBack: json['vehicle_image_back'],
      vehicleStatus: json['vehicle_status'],
      vehicleRejectReason: json['vehicle_reject_reason'],
      govtIdNumber: json['govt_id_number'],
      govtIdFrontImg: json['govt_id_front_img'],
      govtIdBackImg: json['govt_id_back_img'],
      govtIdStatus: json['govt_id_status'],
      govtIdRejectReason: json['govt_id_reject_reason'],
      rcNumber: json['rc_number'],
      rcImgFront: json['rc_imgfront'],
      rcImgBack: json['rc_imgback'],
      rcStatus: json['rc_status'],
      rcRejectReason: json['rc_reject_reason'],
      dlNumber: json['dl_number'],
      dlImgFront: json['dl_imgfront'],
      dlImgBack: json['dl_imgback'],
      dlStatus: json['dl_status'],
      dlRejectReason: json['dl_reject_reason'],
      bankAccountNumber: json['bank_account_number'],
      bankImgFront: json['bank_imgfront'],
      bankImgBack: json['bank_imgback'],
      bankStatus: json['bank_status'],
      bankRejectReason: json['bank_reject_reason'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
