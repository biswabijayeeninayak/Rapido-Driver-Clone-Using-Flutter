class DriverDetails {
  int? status;
  Data? data;
  String? message;

  DriverDetails({this.status, this.data, this.message});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? authId;
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
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.authId,
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
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    authId = json['auth_id'].toString();
    userName = json['user_name'].toString();
    dob = json['dob'].toString();
    email = json['email'].toString();
    gender = json['gender'].toString();
    mobile = json['mobile'].toString();
    address = json['address'].toString();
    image = json['image'].toString();
    status = json['status'].toString();
    action = json['action'].toString();
    currentLat = json['current_lat'].toString();
    currentLng = json['current_lng'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auth_id'] = this.authId;
    data['user_name'] = this.userName;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['image'] = this.image;
    data['status'] = this.status;
    data['action'] = this.action;
    data['current_lat'] = this.currentLat;
    data['current_lng'] = this.currentLng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}