import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ride_sharing_user_app/view/screens/auth/context_extensions.dart';
import 'package:ride_sharing_user_app/view/screens/auth/documents_dashboard.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;

class SubmitDocuments extends StatefulWidget {
  final OrderData? orderData;

  SubmitDocuments({this.orderData});

  @override
  SubmitDocumentsState createState() => SubmitDocumentsState();
}

mixin OrderData {}

class _AadharFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _addSpaces(newValue.text);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addSpaces(String text) {
    // Add a space after every 4 characters
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' '); // Add a space
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}

class _RCFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the lengths are different, indicating a deletion or replacement
    if (newValue.text.length != oldValue.text.length) {
      // Handle Backspace key or deletion
      return newValue;
    }

    // Format your RC Number based on your requirements
    String formattedText = formatRCNumber(newValue.text);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String formatRCNumber(String input) {
    // Convert all characters to uppercase
    input = input.toUpperCase();

    // Remove any non-alphanumeric characters
    input = input.replaceAll(RegExp(r'[^A-Z0-9]'), '');

    // Insert hyphens at specific positions
    if (input.length > 2) {
      input = input.substring(0, 2) + '-' + input.substring(2);
    }
    if (input.length > 5) {
      input = input.substring(0, 5) + '-' + input.substring(5);
    }
    if (input.length > 8) {
      input = input.substring(0, 8) + '-' + input.substring(8);
    }

    return input;
  }
}

class _DLFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the lengths are different, indicating a deletion or replacement
    if (newValue.text.length != oldValue.text.length) {
      // Handle Backspace key or deletion
      return newValue;
    }

    // Format your DL Number based on your requirements
    String formattedText = formatDLNumber(newValue.text);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String formatDLNumber(String input) {
    // Convert all characters to uppercase
    input = input.toUpperCase();

    // Remove any non-alphanumeric characters
    input = input.replaceAll(RegExp(r'[^A-Z0-9]'), '');

    // Insert spaces at specific positions
    if (input.length > 4) {
      input = input.substring(0, 4) + ' ' + input.substring(4);
    }

    return input;
  }
}

class SubmitDocumentsState extends State<SubmitDocuments> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CityModel? cityData;
  // List<ParcelTypeData> parcelTypeList = [];
  // List<String> parcelList = ['Documnets', 'Food', 'Electronics', 'Other'];
  // List<String> vehicleType = [
  //   'ByHand',
  //   'TwoWheeler',
  //   'ThreeVwheeler',
  //   'FourWheeler'
  // ];

  TextEditingController parcelTypeCont = TextEditingController();
  TextEditingController weightController = TextEditingController(text: '1');
  TextEditingController totalParcelController =
      TextEditingController(text: '1');

  TextEditingController pickAddressCont = TextEditingController();
  TextEditingController pickPhoneCont = TextEditingController();
  TextEditingController pickDesCont = TextEditingController();
  TextEditingController pickDateController = TextEditingController();
  TextEditingController pickFromTimeController = TextEditingController();
  TextEditingController pickToTimeController = TextEditingController();

  TextEditingController deliverAddressCont = TextEditingController();
  TextEditingController deliverPhoneCont = TextEditingController();
  TextEditingController deliverDesCont = TextEditingController();
  TextEditingController deliverDateController = TextEditingController();
  TextEditingController deliverFromTimeController = TextEditingController();
  TextEditingController deliverToTimeController = TextEditingController();

  TextEditingController adharController = TextEditingController();

  FocusNode adharFocus = FocusNode();

  File? frontImage;
  File? backImage;

  Future<void> _getImage([int? index]) async {
    final XFile? image =
        await _aadharpicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (index != null && _aadharimageFiles!.length > index) {
          _aadharimageFiles![index] = image;
        } else {
          _aadharimageFiles!.add(image);
        }
      });
    }
  }

  TextEditingController RCController = TextEditingController();

  FocusNode RCFocus = FocusNode();
  File? RCfrontImage;
  File? RCbackImage;

  Future<void> _getRCImage([int? index]) async {
    final XFile? image = await _RCpicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (index != null && _RCimageFiles!.length > index) {
          _RCimageFiles![index] = image;
        } else {
          _RCimageFiles!.add(image);
        }
      });
    }
  }

  TextEditingController DLController = TextEditingController();

  FocusNode DLFocus = FocusNode();
  File? DLfrontImage;
  File? DLbackImage;

  Future<void> _getDLImage([int? index]) async {
    final XFile? image = await _DLpicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (index != null && _DLimageFiles!.length > index) {
          // Replace the image at the given index
          _DLimageFiles![index] = image;
        } else {
          // Add a new image if no index was provided
          _DLimageFiles!.add(image);
        }
      });
    }
  }

  TextEditingController BAController = TextEditingController();

  FocusNode BAFocus = FocusNode();
  File? BAfrontImage;
  File? BAbackImage;

  Future<void> _getBAImage([int? index]) async {
    final XFile? image = await _BApicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (index != null && _BAimageFiles!.length > index) {
          // Replace the image at the given index
          _BAimageFiles![index] = image;
        } else {
          // Add a new image if no index was provided
          _BAimageFiles!.add(image);
        }
      });
    }
  }

  // Future<void> _getImage(ImageSource source, bool isFrontImage) async {
  //   final aadharpicker = ImagePicker();
  //   final pickedImage = await aadharpicker.pickImage(source: source);

  //   if (pickedImage != null) {
  //     setState(() {
  //       if (isFrontImage) {
  //         frontImage = File(pickedImage.path);
  //       } else {
  //         backImage = File(pickedImage.path);
  //       }
  //     });
  //   }
  // }

  FocusNode pickPhoneFocus = FocusNode();
  FocusNode pickDesFocus = FocusNode();
  FocusNode deliverPhoneFocus = FocusNode();
  FocusNode deliverDesFocus = FocusNode();

  // String deliverCountryCode = defaultPhoneCode;
  // String pickupCountryCode = defaultPhoneCode;

  DateTime? pickFromDateTime,
      pickToDateTime,
      deliverFromDateTime,
      deliverToDateTime;
  DateTime? pickDate, deliverDate;
  TimeOfDay? pickFromTime, pickToTime, deliverFromTime, deliverToTime;

  String? pickLat, pickLong, deliverLat, deliverLong;

  int selectedTabIndex = 0;

  bool isDeliverNow = true;
  int isSelected = 1;

  bool? isCash = false;

  // String paymentCollectFrom = PAYMENT_ON_PICKUP;

  DateTime? currentBackPressTime;
  bool isPickSavedAddress = false;
  bool isDeliverySavedAddress = false;
  num totalDistance = 0;
  num totalAmount = 0;
  // List<AddressData> addressList = [];
  // AddressData? pickAddressData;
  // AddressData? deliveryAddressData;
  num weightCharge = 0;
  num distanceCharge = 0;
  num totalExtraCharge = 0;

  // List<PaymentModel> mPaymentList = getPaymentItems();

  // List<ExtraChargeRequestModel> extraChargeList = [];

  int? selectedVehicle;
  // List<VehicleData> vehicleList = [];
  // VehicleData? vehicleData;

  String? selectedOrderSize;
  List<XFile>? _imageFiles = [];
  final ImagePicker _picker = ImagePicker();

  List<XFile>? _aadharimageFiles = [];
  final ImagePicker _aadharpicker = ImagePicker();

  List<XFile>? _RCimageFiles = [];
  final ImagePicker _RCpicker = ImagePicker();

  List<XFile>? _DLimageFiles = [];
  final ImagePicker _DLpicker = ImagePicker();

  List<XFile>? _BAimageFiles = [];
  final ImagePicker _BApicker = ImagePicker();

  var errorColor = Colors.grey.withOpacity(0.15);
  var errorColorimg = Colors.grey.withOpacity(0.15);
  LatLng _initialPosition =
      LatLng(40.7128, -74.0060); // Example coordinates (New York City)

  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: location,
        ),
      );
      // Here, you can add functionality to convert the LatLng to an address
      // and update your text fields (pickAddressCont, pickLat, pickLong)
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
//Upload adhar details

// Future<void> uploadAdhar(String adharnumber) async {
//   print("Upload aadhar");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String userId = prefs.getString('userId').toString();
//   var client = http.Client();
//   try {
//     var request = http.MultipartRequest('POST',
//         Uri.parse('http://kods.tech/munsride/api/storeDocuments/$userId'));
//     request.fields.addAll({
//       'govt_id_number': adharnumber,
//     });
//     if (frontImage != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'govt_id_front_img', frontImage!.path));
//     }

//     if (backImage != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//           'govt_id_back_img', backImage!.path));
//     }

//     var response = await client.send(request);

//     while (response.statusCode == 302) {
//       // Follow the redirection
//       var redirectUrl = response.headers['location'];
//       response = await client.get(Uri.parse(redirectUrl!));
//     }

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print("Adhar Details added ");
//       uploadRc(RCController.text.trim());
//     } else {
//       print("---");
//       print(response.statusCode);
//       print(response.reasonPhrase);
//     }
//   } catch (error) {
//     print("-===-");
//     print('Error: $error');
//   } finally {
//     client.close();
//   }
// }

  Future<void> uploadAdhar(String adharnumber) async {
    print("Upload aadhar");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    print(userId);
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('http://kods.tech/munsride/api/storeDocuments/$userId'));
      request.fields.addAll({
        'govt_id_number': adharnumber,
      });
      if (frontImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'govt_id_front_img', frontImage!.path));
      }

      if (backImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'govt_id_back_img', backImage!.path));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("Adhar Details added ");
        uploadRc(RCController.text.trim());
      } else {
        print("---");
        print(response.statusCode);
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  //   Future<void> uploadRc(String rcnumber) async {
  //   print("Upload RC");

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userId = prefs.getString('userId').toString();
  //   try {
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse('http://kods.tech/munsride/api/storeDocuments/$userId'));
  //     request.fields.addAll({
  //       'govt_id_number': "000000000000",
  //     });
  //     if (RCfrontImage != null) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //           'rc_imgfront', RCfrontImage!.path));
  //     }

  //     if (RCbackImage != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('rc_imgback', RCbackImage!.path));
  //     }
  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //       print("RC Details added ");
  //       uploadDL(DLController.text.trim());
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }


//upload rc details

  Future<void> uploadRc(String rcnumber) async {
    print("Upload RC");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://kods.tech/munsride/api/storeRc/$userId'));
      request.fields.addAll({
        'rc_number': rcnumber,
      });
      if (RCfrontImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'rc_imgfront', RCfrontImage!.path));
      }

      if (RCbackImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('rc_imgback', RCbackImage!.path));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("RC Details added ");
        uploadDL(DLController.text.trim());
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

//upload DL details

  Future<void> uploadDL(String dlnumber) async {
    print("Upload DL");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://kods.tech/munsride/api/storeDl/$userId'));
      request.fields.addAll({
        'dl_number': dlnumber,
      });
      if (DLfrontImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'dl_imgfront', DLfrontImage!.path));
      }

      if (DLbackImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('dl_imgback', DLbackImage!.path));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("DL Details added ");
        uploadBA(BAController.text.trim());
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("---");

      print('Error: $error');
    }
  }

//upload bankAccount Deatils

  Future<void> uploadBA(String banumber) async {
    print("Upload BA");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://kods.tech/munsride/api/storeBank/$userId'));
      request.fields.addAll({
        'bank_account_number': banumber,
      });
      if (BAfrontImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'bank_imgfront', BAfrontImage!.path));
      }

      if (BAbackImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'bank_imgback', BAbackImage!.path));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("Bank Account Details added ");

        Future.delayed(Duration(milliseconds: 200), () {
          Get.off(
            const DocumentsDashboard(
              argument1: true,
              argument2: true,
              argument3: true,
              argument4: true,
            ),
          );
          toast("Documents Uploaded Sucessfully");
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Widget createOrderWidget1() {
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Adhar Number",
                    style: TextStyle(fontSize: 16)), // Add a proper TextStyle
                SizedBox(height: 16),
                TextFormField(
                  controller: adharController,
                  keyboardType: TextInputType.number,
                  focusNode: adharFocus,
                  textInputAction: TextInputAction.done,
                  onTap: () {},
                  onChanged: (value) {
                    if (adharController.text.length == 14) {
                      adharFocus.unfocus();
                    }
                  },
                  decoration: commonInputDecoration(
                      hintText: "Enter your Aadhar Number"),
                  // errorText: language.fieldRequiredMsg,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                    _AadharFormatter(),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32), // Use SizedBox for vertical spacing
          Center(
            child: Text(
              "Please Upload Aadhar Picture",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: 32), // Use SizedBox for vertical spacing
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 45,
              ),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _getImage(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: _aadharimageFiles!.length > index
                        ? Image.file(
                            File(_aadharimageFiles![index].path),
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Aadhar-Front",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                "Aadhar-Back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildSizeBox(String size, bool isSelected) {
    return GestureDetector(
      onTap: () {
        errorColor = Colors.grey.withOpacity(0.15);
        setState(() {
          selectedOrderSize = size;
          print(selectedOrderSize);
        });
      },
      child: Container(
        width: 100,
        height: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade600 : Colors.grey[200],
          border: isSelected
              ? Border.all(color: Colors.orange.shade600, width: 2)
              : null,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget createOrderWidget2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("RC Number", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  controller: RCController,
                  keyboardType: TextInputType.text,
                  focusNode: RCFocus,
                  textInputAction: TextInputAction.done,
                  onTap: () {},
                  onChanged: (value) {
                    if (RCController.text.length == 13) {
                      RCFocus.unfocus();
                    }
                  },
                  decoration:
                      commonInputDecoration(hintText: "Enter your RC Number"),
                  // errorThisFieldRequired: language.fieldRequiredMsg,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                    _RCFormatter(),
                  ]),
            ],
          ),
        ),
        SizedBox(height: 32),
        Center(
            child: Text(
          "Please Upload RC Picture",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 45,
            ),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _getRCImage(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _RCimageFiles!.length > index
                      ? Image.file(
                          File(_RCimageFiles![index].path),
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Front-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              "Back-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget createOrderWidget3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DL Number", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  controller: DLController,
                  keyboardType: TextInputType.text,
                  focusNode: DLFocus,
                  textInputAction: TextInputAction.done,
                  onTap: () {},
                  onChanged: (value) {
                    if (DLController.text.length == 15) {
                      DLFocus.unfocus();
                    }
                  },
                  decoration:
                      commonInputDecoration(hintText: "Enter your DL Number"),
                  // errorThisFieldRequired: language.fieldRequiredMsg,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                    _DLFormatter(),
                  ]),
            ],
          ),
        ),
        SizedBox(height: 32),
        Center(
            child: Text(
          "Please Upload DL Picture",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 45,
            ),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _getDLImage(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: _DLimageFiles!.length > index
                      ? Image.file(
                          File(_DLimageFiles![index].path),
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Front-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              "Back-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget createOrderWidget4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bank Account Number", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  controller: BAController,
                  keyboardType: TextInputType.text,
                  focusNode: BAFocus,
                  textInputAction: TextInputAction.done,
                  onTap: () {},
                  onChanged: (value) {
                    if (BAController.text.length == 14) {
                      BAFocus.unfocus();
                    }
                  },
                  decoration: commonInputDecoration(
                      hintText: "Enter your Account Number"),
                  // errorThisFieldRequired: language.fieldRequiredMsg,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ]),
            ],
          ),
        ),
        SizedBox(height: 32),
        Center(
            child: Text(
          "Please Upload Bank A/C Proof",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 45,
            ),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _getBAImage(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: _BAimageFiles!.length > index
                      ? Image.file(
                          File(_BAimageFiles![index].path),
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Front-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              "Back-Side",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget rowWidget({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 16),
        Text(value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 3,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis)
      ],
    );
  }

  Widget addressComponent(
      {required String title,
      required String address,
      required String phoneNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 20,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: Colors.orange.shade600.withOpacity(0.2)),
            // backgroundColor: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 8,
              ).visible(address.isNotEmpty),
              Row(
                children: [
                  Icon(Icons.call, size: 14),
                  SizedBox(
                    width: 8,
                  ),
                  Text(phoneNumber, style: secondaryTextStyle())
                      .visible(phoneNumber.isNotEmpty),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> getLabelForIndex = [
    'ID PROOF',
    'RC PROOF',
    'DL PROOF',
    'BANK A/C'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Documents",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[600],
        elevation: 8,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, top: 30, right: 16, bottom: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: selectedTabIndex == index ? 35 : 25,
                            width: selectedTabIndex == index ? 35 : 25,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade600,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.orange.shade600,
                              ),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: primaryTextStyle(
                                color: selectedTabIndex >= index
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                // Add your names or labels here based on the index
                                getLabelForIndex[index],
                                style: TextStyle(
                                  color: Colors.orange[600],
                                  fontWeight: selectedTabIndex >= index
                                      ? FontWeight.bold
                                      : null,
                                )),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  30.height,
                  if (selectedTabIndex == 0) createOrderWidget1(),
                  if (selectedTabIndex == 1) createOrderWidget2(),
                  if (selectedTabIndex == 2) createOrderWidget3(),
                  if (selectedTabIndex == 3) createOrderWidget4(),
                ],
              ),
            ),
          ),
          // Observer(
          //   builder: (context) => loaderWidget().visible(appStore.isLoading),
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            if (selectedTabIndex != 0)
              outlineButton("previous", () {
                FocusScope.of(context).requestFocus(new FocusNode());
                selectedTabIndex--;
                setState(() {});
              }, color: Colors.orange[600])
                  .paddingRight(16)
                  .expand(),
            commonButton(selectedTabIndex != 3 ? "next" : "Proceed", () async {
              if (selectedTabIndex == 0 && (_aadharimageFiles!.length < 2)) {
                toast("Aadhar images are Required!");

                setState(() {});
              } else if (selectedTabIndex == 0 &&
                  (adharController.text.isEmpty)) {
                toast("Aadhar Number is Required!");
                FocusScope.of(context).requestFocus(RCFocus);

                Future.delayed(Duration(milliseconds: 200), () {
                  FocusScope.of(context).requestFocus(adharFocus);
                });

                setState(() {});
              } else if (selectedTabIndex == 1 && (_RCimageFiles!.length < 2)) {
                toast("RC images are Required!");

                setState(() {});
              } else if (selectedTabIndex == 1 && (RCController.text.isEmpty)) {
                toast("RC Number is Required!");
                // FocusScope.of(context).requestFocus(RCFocus);

                Future.delayed(Duration(milliseconds: 200), () {
                  FocusScope.of(context).requestFocus(RCFocus);
                });

                setState(() {});
              } else if (selectedTabIndex == 2 && (_DLimageFiles!.length < 2)) {
                toast("DL images are Required!");

                setState(() {});
              } else if (selectedTabIndex == 2 && (DLController.text.isEmpty)) {
                toast("DL Number is Required!");
                // FocusScope.of(context).requestFocus(RCFocus);

                Future.delayed(Duration(milliseconds: 200), () {
                  FocusScope.of(context).requestFocus(DLFocus);
                });

                setState(() {});
              } else if (selectedTabIndex == 3 && (BAController.text.isEmpty)) {
                toast("Account Number is Required!");
                // FocusScope.of(context).requestFocus(RCFocus);

                Future.delayed(Duration(milliseconds: 200), () {
                  FocusScope.of(context).requestFocus(BAFocus);
                });

                setState(() {});
              } else if (selectedTabIndex == 3 && (_BAimageFiles!.length < 2)) {
                toast("Bacnk A/C proof images are Required!");

                setState(() {});
              } else {
                print("hi");
                print(RCController.text);
                print(adharController.text);
                print(DLController);
                setState(() {});

                FocusScope.of(context).requestFocus(new FocusNode());
                if (selectedTabIndex != 3) {
                  if (_formKey.currentState!.validate()) {
                    Duration difference = Duration();
                    Duration differenceCurrentTime = Duration();
                    if (!isDeliverNow) {
                      pickFromDateTime = pickDate!.add(Duration(
                          hours: pickFromTime!.hour,
                          minutes: pickFromTime!.minute));
                      pickToDateTime = pickDate!.add(Duration(
                          hours: pickToTime!.hour,
                          minutes: pickToTime!.minute));
                      deliverFromDateTime = deliverDate!.add(Duration(
                          hours: deliverFromTime!.hour,
                          minutes: deliverFromTime!.minute));
                      deliverToDateTime = deliverDate!.add(Duration(
                          hours: deliverToTime!.hour,
                          minutes: deliverToTime!.minute));
                      difference =
                          pickFromDateTime!.difference(deliverFromDateTime!);
                      differenceCurrentTime =
                          DateTime.now().difference(pickFromDateTime!);
                    }
                    if (differenceCurrentTime.inMinutes > 0)
                      return toast("pickupCurrentValidationMsg");
                    if (difference.inMinutes > 0)
                      return toast("pickupDeliverValidationMsg");
                    selectedTabIndex++;
                    if (selectedTabIndex == 3) {
                      // getTotalAmount();
                    }
                    setState(() {});
                  }
                } else {
                  showConfirmDialogCustom(context,
                      title: "Are you sure want to submit your documents?",
                      positiveText: "yes",
                      primaryColor: Colors.orange.shade600,
                      negativeText: "no", onAccept: (v) async {
                    // createOrderApiCall(ORDER_CREATED);
                    // Navigator.pop(context);
                    print("call");
                    await uploadAdhar(adharController.text.trim());
                  });
                }
              }
            }).expand()
          ],
        ),
      ),
    );
  }

  Widget outlineButton(String title, Function() onTap,
      {double? width, Color? color}) {
    return SizedBox(
      width: width,
      child: TextButton(
        child: Text(
          title,
          style: boldTextStyle(color: color ?? textPrimaryColorGlobal),
        ),
        onPressed: onTap,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              side: BorderSide(color: color ?? Colors.red)),
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget commonButton(String title, Function() onTap,
      {double? width, Color? color, Color? textColor}) {
    return SizedBox(
      width: width,
      child: AppButton(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius)),
        elevation: 0,
        child: Text(
          title,
          style: boldTextStyle(color: textColor ?? white),
        ),
        color: color ?? Colors.orange.shade600,
        onTap: onTap,
      ),
    );
  }

  InputDecoration commonInputDecoration(
      {String? hintText,
      IconData? suffixIcon,
      Function()? suffixOnTap,
      Widget? dateTime,
      Widget? prefixIcon,
      bool? isFill = true}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(16),
      filled: true,
      prefixIcon: prefixIcon,
      isDense: true,
      hintText: hintText != null ? hintText : '',
      hintStyle: secondaryTextStyle(size: 16, color: Colors.grey),
      fillColor: Colors.orange.shade600.withOpacity(0.06),
      counterText: '',
      suffixIcon: dateTime != null
          ? dateTime
          : suffixIcon != null
              ? Icon(suffixIcon, color: Colors.orange.shade600, size: 22)
                  .onTap(suffixOnTap)
              : null,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Colors.orange.shade600),
          borderRadius: BorderRadius.circular(defaultRadius)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange.shade600),
          borderRadius: BorderRadius.circular(defaultRadius)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(defaultRadius)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(defaultRadius)),
    );
  }
}
