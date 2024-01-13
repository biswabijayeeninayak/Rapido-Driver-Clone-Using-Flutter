import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/my_offer/repository/my_offer_repo.dart';

class MyOfferController extends GetxController implements GetxService{
  final MyOfferRepo myOfferRepo;

  MyOfferController({required this.myOfferRepo});

  List<String> myOfferTypeList = ['regular', 'my_level'];
  int _myOfferTypeIndex = 0;
  int get myOfferTypeIndex => _myOfferTypeIndex;


  void setMyOfferTypeIndex(int index){
    _myOfferTypeIndex = index;
    update();
  }
}