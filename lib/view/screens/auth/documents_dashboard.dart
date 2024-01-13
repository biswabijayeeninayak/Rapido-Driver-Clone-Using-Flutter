
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/commonScaffold.dart';
import 'package:ride_sharing_user_app/view/screens/auth/createAccountScreen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/document_verification.dart';
import 'package:ride_sharing_user_app/view/screens/auth/submitDocument.dart';
import 'package:ride_sharing_user_app/view/screens/auth/vehicle_documents.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class DocumentsDashboard extends StatefulWidget {
  final bool argument1;
  final bool argument2;
  final bool argument3;
  final bool argument4;
  const DocumentsDashboard({super.key, required this.argument1, required this.argument2, required this.argument3, required this.argument4});

  @override
  State<DocumentsDashboard> createState() => _DocumentsDashboardState();
}

class _DocumentsDashboardState extends State<DocumentsDashboard> {
  bool shouldShowRow = false;
  
 
  @override
  Widget build(BuildContext context) {
    bool argument1 = widget.argument1;
    bool argument2 = widget.argument2;
    bool argument3 = widget.argument3;
    bool argument4 = widget.argument4;
    return CommonScaffoldComponent(
      appBar: CustomAppBar(
        // forceMaterialTransparency: true,
        // automaticallyImplyLeading: false, 
        title: 'Upload Documents',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Image.asset(Images.logo, width: 200, height: 200,),
                ),
                8.height,
                Center(
                  child: Text(
                    "Create Your Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                25.height,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      argument1 ? AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Create Account",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.verified_sharp,
                                      size: 20, color: Colors.white),
                                ],
                              ),
                           
                        onTap: () {
                          toast("This Field is already been submitted! Kindly complete next steps to start the ride.");
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ) :
                      AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Create Account",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                        onTap: () {
                          // setState(() {
                          // });
          
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CreateAccount()),
                          // );
                          Get.to(() => CreateAccount());
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ),
                      25.height,
                      argument2 ? AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Submit Documents",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.verified_sharp,
                                      size: 20, color: Colors.white),
                                ],
                              ),
                           
                        onTap: () {
                          toast("This Field is already been submitted! Kindly complete next steps to start the ride.");
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ) :
                      AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Submit Documents",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                        onTap: () {
                          setState(() {
                          });
          
                          if (argument1){
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SubmitDocuments()),
                          // );
                          Get.to(VehicleDocuments());
                          }
                          else{
                            toast("Complete create Account process to Submit Documents");
                          }
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ),
                      25.height,
                      argument4 ? AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Document Verifiacation",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.verified_sharp,
                                      size: 20, color: Colors.white),
                                ],
                              ),
                           
                        onTap: () {
                          toast("This Field is already been submitted! Kindly complete next steps to start the ride.");
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ) :
                      AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Document Verifiacation",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                        onTap: () {
                          setState(() {
                          });
          
                          if (argument2 && argument1){
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CreateAccount()),
                          // );
                          Get.to(DocumentVerification());
                          }
                          else{
                            toast("Complete Submit document section to proceed with Document Verification ");
                          }
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ),
                      25.height,
                      
                      AppButton(
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Get Your First trip",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                        onTap: () {
                          setState(() {
                          });
          
                          if (argument2 && argument1 && argument4){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()),
                          );
                          }
                          else{
                            toast("Your Document Verification is still pending!");
                          }
                        },
                        // width: context.width(),
                        color: Colors.orange[600],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
