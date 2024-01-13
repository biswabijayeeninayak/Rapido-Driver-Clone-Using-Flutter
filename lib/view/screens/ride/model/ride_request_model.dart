class RideRequestModel{
  String? from;
  String? to;
  String? route1;
  String? route2;
  String? pickupTime;
  Customer? customer;

  RideRequestModel(
      {this.from,
      this.to,
      this.route1,
      this.route2,
      this.pickupTime,
      this.customer});
}


class Customer{
  String? name;
  String? image;
  String? ratting;
  String? fair;

  Customer({this.name, this.image, this.ratting, this.fair});
}

