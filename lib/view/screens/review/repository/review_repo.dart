import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/review/model/review.dart';

class ReviewRepo{
  final ApiClient apiClient;

  ReviewRepo({required this.apiClient});


  Future<Response> getReviewList() async {
    List<Review> reviewList=[];
    try {
      reviewList = [
        Review(id: 1,
            orderId: 1000105, rating: 5,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 0,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),

        Review(id: 2,
            orderId: 1000104, rating: 4,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),

        Review(id: 3,
            orderId: 1000103, rating: 3,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 0,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),
        Review(id: 4,
            orderId: 1000102, rating: 2,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),
        Review(id: 5,
            orderId: 1000101, rating: 5,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 0,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),




      ];


      Response response = Response(body: reviewList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

  Future<Response> getSavedReviewList() async {
    List<Review> reviewList=[];
    try {
      reviewList = [
        Review(id: 1,
            orderId: 1000105, rating: 5,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),

        Review(id: 2,
            orderId: 1000104, rating: 4,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),

        Review(id: 3,
            orderId: 1000103, rating: 3,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),
        Review(id: 4,
            orderId: 1000102, rating: 2,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),
        Review(id: 5,
            orderId: 1000101, rating: 5,
            status: 1, createdAt: '2022-09-14T13:49:51.000000Z', isSaved: 1,customerName: 'kuddus',customerImage: '',comment: '“I am very happy during pune - mahableshwar trip, very good driver and car car was very good and driver was good cost of travel in budget overall ...........'
        ),




      ];


      Response response = Response(body: reviewList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }


}