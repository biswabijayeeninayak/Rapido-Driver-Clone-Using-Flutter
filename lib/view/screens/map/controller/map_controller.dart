import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/images.dart';


class RiderMapController extends GetxController implements GetxService {

  String _riderStatus = 'pending';
  String get riderStatus => _riderStatus;
  final double _persistentContentHeight = 250;
  double get persistentContentHeight => _persistentContentHeight;

  final bool _showCancelTripButton = false;
  bool get showCancelTripButton => _showCancelTripButton;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _checkIsRideAccept = false;
  bool get checkIsRideAccept => _checkIsRideAccept;

  double infoContainerHeight = 200;



  final List<MarkerData> _customMarkers = [];
  List<MarkerData> get customMarkers => _customMarkers;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  GoogleMapController? mapController;



  bool profileOnline = true;
  void toggleProfileStatus(){
    profileOnline = ! profileOnline;
    update();
  }


  bool tripPaused = false;
  void tripStatusToggle(){
    tripPaused = ! tripPaused;
    update();
  }

  bool clickedAssistant = false;
  void toggleAssistant(){
    clickedAssistant = !clickedAssistant;
    update();
  }

  bool isExpanded = false;
  void toggleExpanded(){
    isExpanded = !isExpanded;
    if(isExpanded){
      infoContainerHeight = 500;
    }
    update();
  }

  List<String> pickHourList = ['Morning pick time', '6am-7am', '7am-8am'];

  bool activatedPack = false;
  void toggleActivatedPack(){
    activatedPack = !activatedPack;
    update();
  }


  bool showCompass = true;
  void toggleCompass(){
    showCompass = !showCompass;
    update();
}


  int _stayOnlineTypeIndex = 0;
  int get stayOnlineTypeIndex => _stayOnlineTypeIndex;
  void setStayOnlineTypeIndex(int index){
    _stayOnlineTypeIndex = index;
    // if(_stayOnlineTypeIndex> 4){
    //   getPolyline(
    //       from: _initialPosition,
    //       to:  _targetPosition
    //   );
    //   setFromToMarker(
    //       from: _initialPosition,
    //       to:  _targetPosition
    //   );
    // }
    update();
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  final double _distance = 0;
  double get distance => _distance;

  late Position _position;
  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

   final LatLng _targetPosition = const LatLng(23.8080606, 90.4071797);
  LatLng get targetPosition => _targetPosition;

  final LatLng _customerPosition = const LatLng(12,12);//Get.find<AuthController>().currentLocation;
  late LatLng _destinationPosition;
  LatLng get customerInitialPosition => _customerPosition;
  LatLng get destinationPosition => _destinationPosition;



  int _reload = 0;
  int get reload => _reload;
  MarkerId myMarkerId = const MarkerId('myMarker');
  MarkerId customerMarkerId = const MarkerId('customerMarker');


  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();





  }

  void initializeData() {
    getCurrentLocation();
    polylines = {};
    _riderStatus = 'pending';
    _isLoading = false;
  }


  void acceptedRideRequest(){
    _checkIsRideAccept = !_checkIsRideAccept;
  }

  void setMapController(GoogleMapController mapController) {
    mapController = mapController;
  }

  void onGoingStatus(String status){
    _riderStatus = status;
    update();
  }



  Future<Position> getCurrentLocation({bool isAnimate = true}) async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _position = newLocalData;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
      if(isAnimate) {
        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialPosition, zoom: 16)));
      }
    }catch(e){
      debugPrint('');
    }

    return _position;
  }


  //
  // void getPolyline({required LatLng from, required LatLng to}) async {
  //   List<LatLng> polylineCoordinates = [];
  //
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     AppConstants.polylineMapKey,
  //     const PointLatLng(23.83721, 90.363715),
  //     const PointLatLng(23.8080606, 90.4071797),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   } else {
  //
  //   }
  //   _addPolyLine(polylineCoordinates);
  // }
  //
  //
  // _addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = const PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     points: polylineCoordinates,
  //     width: 5,
  //     color: Theme.of(Get.context!).primaryColor,
  //   );
  //   polylines[id] = polyline;
  //   update();
  // }

  void setFromToMarker({required LatLng from, required LatLng to}) async{
    _customMarkers.clear();
    _customMarkers.add(MarkerData(
      marker: Marker(markerId: const MarkerId('id-0'), position: from),
      child: Image.asset(Images.targetLocationIcon,  width: _stayOnlineTypeIndex > 4 ? 30 : 0),
    ));

    _customMarkers.add(MarkerData(
      marker: Marker(markerId: const MarkerId('id-1'), position: to),
      child: Image.asset(Images.fromIcon,  width: _stayOnlineTypeIndex > 4 ? 40 : 0),
    ));

    try {

      LatLngBounds? bounds;
      if(mapController != null) {
        bounds = LatLngBounds(
          southwest: _initialPosition,
          northeast: _targetPosition,
        );
      }

      LatLng centerBounds = LatLng(
        (bounds!.northeast.latitude + bounds.southwest.latitude)/2,
        (bounds.northeast.longitude + bounds.southwest.longitude)/2,
      );
      mapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: centerBounds, zoom: GetPlatform.isWeb ? 10 : 17)));
      zoomToFit(mapController!, bounds, centerBounds, padding: 1.5);

    }catch(e) {
      // debugPrint(e);
    }


    await Future.delayed(const Duration(milliseconds: 500));
    _reload = 0;
    if(_reload == 0) {
      update();
      _reload = 1;
    }
  }

  Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds, LatLng centerBounds, {double padding = 0.5}) async {
    bool keepZoomingOut = true;

    while(keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if(fits(bounds, screenBounds)){
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      }
      else {
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  }




}