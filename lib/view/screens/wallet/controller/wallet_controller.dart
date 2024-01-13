import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/repository/wallet_repo.dart';

class WalletController extends GetxController implements GetxService{
  final WalletRepo walletRepo;

  WalletController({required this.walletRepo});


  List<String> walletTypeList =['wallet_money', 'transaction', 'my_point'];
  List<String> walletFilterType =['select','today', 'this_month', 'this_year'];
  List<String> walletTransactionType =['select','pending', 'withdrawn', 'cancelled'];
  List<String> selectedFilterType = ['select','today', 'this_month', 'this_year'];
  int _walletTypeIndex = 0;
  int get walletTypeIndex => _walletTypeIndex;

  List<MyEarnModel> myEarnList =[];

  String selectedValue = 'select';

  String _selectedFilterTypeName = 'pending';
  String get selectedFilterTypeName => _selectedFilterTypeName;

  void setFilterTypeName(String name){
    _selectedFilterTypeName = name;
    update();
  }

  bool isConvert = false;
  void toggleConvertCard(bool value){
    isConvert = value;
    update();
  }

  void setWalletTypeIndex(int index){
    _walletTypeIndex = index;
    if(_walletTypeIndex == 0){
      selectedFilterType =[];
      selectedValue = 'today';
      selectedFilterType.addAll(walletFilterType);
    }else{
      selectedFilterType = [];
      selectedValue = 'pending';
      selectedFilterType.addAll(walletTransactionType);
    }
    update();
  }

  void getMyEarnList() async {
    Response response = await walletRepo.getMyEarnList();
    if (response.statusCode == 200) {
      myEarnList = [];
      myEarnList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


}