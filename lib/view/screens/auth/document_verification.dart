
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ride_sharing_user_app/view/screens/auth/commonScaffold.dart';
import 'package:ride_sharing_user_app/view/screens/auth/documents_dashboard.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';

class DocumentVerification extends StatefulWidget {
  const DocumentVerification({super.key});

  @override
  State<DocumentVerification> createState() => _DocumentVerificationState();
}

class _DocumentVerificationState extends State<DocumentVerification> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffoldComponent(
        appBarTitle: "Document Verification",
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 24.0, bottom: 16),
                        child: Center(
                          child: Icon(
                            Icons.folder_shared_outlined,
                            size: 95.0,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Your Document has been saved",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              16.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Documents",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  // VerticalDivider(
                                  // color: Colors.grey.withOpacity(0.5)),
                                  Text(
                                    "Images",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  // VerticalDivider(
                                  // color: Colors.grey.withOpacity(0.5)),
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text("Front"),
                              //     24.width,
                              //     Text("Back")
                              //   ],
                              // ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Table(
                                  border: TableBorder(),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  
                                    
                                  
                                  columnWidths: {
                                    0: FlexColumnWidth(40),
                                    1: FlexColumnWidth(15),
                                    2: FlexColumnWidth(15),
                                    3: FlexColumnWidth(30),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.4,
                                                color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(child: SizedBox(height: 40)),
                                        TableCell(
                                            child:
                                                Center(child: Text('Front'))),
                                        TableCell(
                                            child: Center(child: Text('Back'))),
                                        TableCell(child: SizedBox(height: 30)),
                                      ],
                                    ),

                                    TableRow(
                                      
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.4,
                                                color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(
                                        
                                          child:
                                              Center(child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text('ID PROOF'),
                                              )),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Front Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded,  color: Colors.blue,),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Back Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text('Pending',
                                                style: TextStyle(
                                                    color: Colors.orange)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.4,
                                                color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(
                                          child:
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Center(child: Text('RC')),
                                              ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Front Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Back Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text('Pending',
                                                style: TextStyle(
                                                    color: Colors.orange)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.4,
                                                color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(
                                          child:
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Center(child: Text('DL')),
                                              ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Front Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Back Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text('Pending',
                                                style: TextStyle(
                                                    color: Colors.orange)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.4,
                                                color: Colors.grey)),
                                      ),
                                      children: [
                                        TableCell(
                                          child:
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Center(child: Text('BANK A/C Proof')),
                                              ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Front Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your action on icon tap
                                                print('Back Icon Tapped');
                                              },
                                              child: Icon(
                                                  Icons.remove_red_eye_rounded, color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text('Pending',
                                                style: TextStyle(
                                                    color: Colors.orange,)),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                           
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print("Proceed");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentsDashboard(argument1: true, argument2: true,argument3: false,argument4: true,)));
                        },
                        child: Icon(Icons.arrow_circle_right_outlined, color: Colors.blue,size: 40,)
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
