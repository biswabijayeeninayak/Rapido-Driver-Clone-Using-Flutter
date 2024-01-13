class Review {
  int? id;
  int? orderId;
  String? comment;
  int? rating;
  int? status;
  String? createdAt;
  int? isSaved;
  String? customerName;
  String? customerImage;

  Review(
      {this.id,
        this.orderId,
        this.comment,
        this.rating,
        this.status,
        this.createdAt,
        this.isSaved,
        this.customerName,
        this.customerImage
      });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['order_id'] != null){
      orderId = int.parse(json['order_id'].toString());
    }
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    createdAt = json['created_at'];
    isSaved = int.parse(json['is_saved'].toString());

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['is_saved'] = isSaved;


    return data;
  }
}