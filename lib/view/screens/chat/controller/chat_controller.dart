import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/chat/repository/chat_repo.dart';

class ChatController extends GetxController implements GetxService{
  final ChatRepo chatRepo;

  ChatController({required this.chatRepo});



  List<String> userType = ['customer', 'admin'];

  int _userTypeIndex = 0;
  int get userTypeIndex => _userTypeIndex;

  void setUserTypeIndex(int index){
    _userTypeIndex = index;
    update();
  }

  List <XFile>? _pickedImageFiles =[];
  List <XFile>? get pickedImageFile => _pickedImageFiles;

  FilePickerResult? _otherFile;
  FilePickerResult? get otherFile => _otherFile;

  File? _file;
  PlatformFile? objFile;
  File? get file=> _file;

  List<MultipartBody> _selectedImageList = [];
  List<MultipartBody> get selectedImageList => _selectedImageList;

  final List<dynamic> _conversationList=[];
  List<dynamic> get conversationList => _conversationList;

  final bool _paginationLoading = true;
  bool get paginationLoading => _paginationLoading;

  int? _messagePageSize;
  final int _messageOffset = 1;
  int? get messagePageSize => _messagePageSize;
  int? get messageOffset => _messageOffset;

  int? _pageSize;
  final int _offset = 1;
  final bool _isLoading = false;
  bool? get isLoading => _isLoading;
  final String _name='';
  String get name => _name;
  final String _image='';
  String get image => _image;

  int? get pageSize => _pageSize;
  int? get offset => _offset;

  var conversationController = TextEditingController();
  final GlobalKey<FormState> conversationKey  = GlobalKey<FormState>();

  @override
  void onInit(){
    super.onInit();
    conversationController.text = '';
  }

  void pickMultipleImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        _pickedImageFiles!.removeAt(index);
        _selectedImageList.removeAt(index);
      }
    }else {
      _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
      if (_pickedImageFiles != null) {
        for(int i =0; i< _pickedImageFiles!.length; i++){
          _selectedImageList.add(MultipartBody('files[$i]',_pickedImageFiles![i]));
        }
      }
    }
    update();
  }


  void pickOtherFile(bool isRemove) async {
    if(isRemove){
      _otherFile=null;
      _file = null;
    }else{
      _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
      if (_otherFile != null) {
        objFile = _otherFile!.files.single;
      }
    }
    update();
  }

  void removeFile() async {
    _otherFile=null;
    update();
  }

  cleanOldData(){
    _pickedImageFiles = [];
    _selectedImageList = [];
    _otherFile = null;
    _file = null;
  }


}