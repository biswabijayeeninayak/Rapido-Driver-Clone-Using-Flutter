import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/my_activity_list_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/ongoing_ride_card.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/profile_info_card.dart';
import 'package:ride_sharing_user_app/view/screens/home/widget/reward_list_view.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/profile_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widget/profile_menu_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_delegate.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drawer.dart';


class HomeMenu extends GetView<ProfileController> {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: const ProfileMenuScreen(),
        mainScreen: const HomeScreen(),
        borderRadius: 24.0,
        isRtl: !Get.find<LocalizationController>().isLtr,
        angle: -5.0,
        menuBackgroundColor: Theme.of(context).primaryColor,
        slideWidth: MediaQuery.of(context).size.width * 0.85,
        mainScreenScale: .4,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.find<RideController>().getMyActivityList();
    Get.find<RideController>().totalHourActivityList();
    Get.find<ProfileController>().getRewardList();
    Get.find<ProfileController>().getTermList();
    Get.find<RideController>().getRideRequestList();
    _checkPermission(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [

              SliverPersistentHeader(delegate: SliverDelegate(child: Column(children: [
                CustomAppBar(title: 'dashboard'.tr, showBackButton: false, onTap: (){
                  Get.find<ProfileController>().toggleDrawer();
                },),
                const ProfileStatusCard(),
              ],), height: 245), pinned: true,),
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    
                    OngoingRideCard(),

                    MyActivityListView(),

                    RewardListView(),

                    SizedBox(height: 100,),


                  ],
                ),
              )
            ],
          ),
          Positioned(child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: ()=>Get.to(()=> const MapScreen()),
                  onHorizontalDragEnd: (DragEndDetails details){
                    _onHorizontalDrag(details);
                    Get.to(()=> const MapScreen());
                  },

                  child: SizedBox(width: Dimensions.iconSizeExtraLarge,
                      child: Image.asset(Images.homeToMapIcon))))),
        ],
      ),
    );
  }
  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity!.compareTo(0) == -1) {
      debugPrint('dragged from left');
    } else {
      debugPrint('dragged from right');
    }
  }

  void _checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: true,
      //     onPressed: () async {
      //       Navigator.pop(context);
      //       await Geolocator.requestPermission();
      //
      //     }));
    }else if(permission == LocationPermission.deniedForever) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false,
      //     onPressed: () async {
      //       Navigator.pop(context);
      //       await Geolocator.openAppSettings();
      //
      //     }));
    }
  }
}





