import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  bool? _isLoading = false;
  bool _acceptTerms = false;



  AuthController({required this.authRepo});
  bool? get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;


  final String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  XFile? _pickedProfileFile ;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile? _pickedIdentityImageFront ;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? _pickedIdentityImageBack ;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;


  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();

  void pickImage(bool isBack, bool isProfile) async {
      if(isBack){
        _pickedIdentityImageBack = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      }else if(isProfile){
        _pickedProfileFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      } else{
        _pickedIdentityImageFront = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
      }
    update();
  }

  // Future<void> login(String phone, String password) async {
  //   _isLoading = true;
  //   update();
  //   _navigateLogin(phone,password);
  //   _isLoading = false;
  //   update();

  // }

  _navigateLogin(String phone, String password){

    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(phone, password);
    } else {
      clearUserNumberAndPassword();
    }
    Get.offAll(()=> const DashboardScreen());
  }

  Future<void> forgetPassword() async {
    _isLoading = true;
    update();
    Response? response = await authRepo.forgetPassword("_numberWithCountryCode");
    if (response!.body['response_code'] == 'default_200') {
      _isLoading = false;
      customSnackBar('successfully_sent_otp'.tr, isError: false);
    }else{
      _isLoading = false;
      customSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> verifyToken(String phoneOrEmail) async {
    //Response? response = await authRepo.verifyToken(phoneOrEmail, _verificationCode);

    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String phoneOrEmail) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(_mobileNumber, _otp, "newPasswordController.value.text", "confirmNewPasswordController.value.text");
    if (response!.body['response_code'] == 'default_password_reset_200') {

      customSnackBar('password_change_successfully'.tr, isError: false);
    }else{
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }



  //
  // Future<ResponseModel> checkEmail(String email) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await authRepo.checkEmail(email);
  //   ResponseModel responseModel;
  //   if (response!.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["token"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> verifyEmail(String email, String token) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await authRepo.verifyEmail(email, _verificationCode);
  //   ResponseModel responseModel;
  //   if (response!.statusCode == 200) {
  //     authRepo.saveUserToken(token);
  //     await authRepo.updateToken();
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> verifyPhone(String phone, String token) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await authRepo.verifyPhone(phone, _verificationCode);
  //   ResponseModel responseModel;
  //   if (response!.statusCode == 200) {
  //     authRepo.saveUserToken(token);
  //     await authRepo.updateToken();
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<void> updateZone() async {
  //   Response? response = await authRepo.updateZone();
  //   if (response!.statusCode == 200) {
  //     // Nothing to do
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  // }

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if(_verificationCode.isNotEmpty){
      _otp = _verificationCode;
    }
    update();
  }


  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
    update();
  }
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async{
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }
  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }
  Future <void> setUserToken(String token) async{
     authRepo.saveUserToken(token);
  }

}