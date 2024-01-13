import 'dart:async';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/set_destination_screen.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/assistant_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/close_destination_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/custom_icon_card.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/driver_header_info_widget.dart';
import 'package:ride_sharing_user_app/view/screens/map/widget/expendale_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'dart:math' as math;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  CameraPosition? _cameraPosition;
  @override
  void initState() {
    Get.find<RideController>().getRideRequestList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RiderMapController>(
          builder: (riderController) {
        Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();
        if(riderController.mapController != null) {
          mapCompleter.complete(riderController.mapController);
        }
        return ExpandableBottomSheet(

          background: Stack(
            children: [
              CustomGoogleMapMarkerBuilder(
                  customMarkers: riderController.customMarkers,
                  builder: (context, markers) {
                    return GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition:  CameraPosition(
                        target:  riderController.initialPosition,
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController controller){
                        riderController.mapController = controller;
                        // LatLng destination =  riderController.targetPosition;
                        // if(riderController.stayOnlineTypeIndex > 4) {
                        //   riderController.getPolyline(from: riderController.initialPosition, to: destination);
                        // }
                        riderController.setFromToMarker(from: riderController.initialPosition, to: riderController.targetPosition) ;

                      },
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 15),
                      markers: Set<Marker>.of(markers ?? []),
                      polylines: Set<Polyline>.of(riderController.polylines.values),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: true,
                      onCameraIdle: () {

                      },
                      onCameraMove: ((position){
                        _cameraPosition = position;
                        debugPrint(_cameraPosition!.target.latitude.toString());
                      }),
                    );
                  }
              ),

              Positioned(bottom: 300,right: 0,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GetBuilder<RiderMapController>(
                    builder: (riderMapController) {
                      return Column(children: [
                        CustomIconCard(index: 10,icon: Images.showCampusIcon,selectedIndex: riderMapController.stayOnlineTypeIndex,
                            onTap: (){
                          if(riderMapController.stayOnlineTypeIndex == 10){
                            showDialog(context: context, builder: (_)=> const CloseDestinationNarrowWidget());
                          }else{
                            Get.to(()=> const SetDestinationScreen());
                          }


                            }
                        ),
                        CustomIconCard(index: 40,icon: Images.showDirectionIcon,selectedIndex: riderMapController.stayOnlineTypeIndex, onTap: ()=> riderMapController.toggleCompass()),
                        CustomIconCard(index: 5,icon: Images.currentLocation,selectedIndex: riderMapController.stayOnlineTypeIndex,onTap: (){
                          riderMapController.getCurrentLocation();
                        }),
                      ],);
                    }
                  ),
                ),
              ),

              const DriverHeaderInfoWidget(),

              Positioned(child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: ()=> Get.off(()=> const DashboardScreen()),
                      onHorizontalDragEnd: (DragEndDetails details){
                        _onHorizontalDrag(details);
                        Get.off(()=> const DashboardScreen());
                      },

                      child: SizedBox(width: Dimensions.iconSizeExtraLarge,
                          child: Image.asset( Images.mapToHomeIcon))))),

              // if(riderController.stayOnlineTypeIndex < 5 || riderController.stayOnlineTypeIndex == 9 || riderController.stayOnlineTypeIndex == 10)
              Positioned(top: 0,bottom: 200,left: 0,right: 0,
                  child: Align(alignment: Alignment.center,child: SizedBox(width: Get.width/2,
                    child: Image.asset(Images.directionIconMap),),)),

              if(riderController.showCompass)
              Positioned(top: 0, bottom: 200, left: Dimensions.compassPadding, right: Dimensions.compassPadding,
                  child: Align(alignment: Alignment.center,child: _buildCompass(),))

            ],
          ),

          persistentHeader: SizedBox(height: 160,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  onTap: (){
                    riderController.toggleAssistant();
                    showDialog(context: context, builder: (_)=> const AssistantDialog(), barrierDismissible: false);
                  },
                  child: SizedBox(width: 100,
                    child: Image.asset(riderController.clickedAssistant ? Images.assistantIconActive : Images.assistantIcon),),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: ListView.builder(
                      itemCount: riderController.pickHourList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                              color: Theme.of(context).cardColor,
                              border: Border.all(color: Theme.of(context).primaryColor,width: .5)),
                            child: Center(child: Text(riderController.pickHourList[index]))),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          persistentContentHeight: riderController.persistentContentHeight,

          expandableContent:  const RiderBottomSheet(),

        );
      }
      ),
    );
  }

  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity!.compareTo(0) == -1) {

    } else {

    }
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        double? direction;
        if(snapshot.data != null){
          direction = snapshot.data!.heading;
        }

        return snapshot.data != null? Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: (direction! * (math.pi / 180) * -1),
            child: Image.asset(Images.compass),
          ),
        ):const SizedBox();
      },
    );
  }

}
