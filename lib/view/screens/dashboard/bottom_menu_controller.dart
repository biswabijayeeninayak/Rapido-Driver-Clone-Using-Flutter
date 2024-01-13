import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/notification/notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/trip/trip_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/wallet_screen.dart';


class BottomMenuController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  final List<Widget> screen = [
    const HomeMenu(),
    const TripHistoryMenu(),
    const NotificationMenu(),
    const WalletScreenMenu(),
  ];
  Widget _currentScreen = const HomeMenu();
  Widget get currentScreen => _currentScreen;

  resetNavBar(){
    _currentScreen = const HomeMenu();
    _currentTab = 0;
  }

  selectHomePage() {
    _currentScreen = const HomeMenu();
    _currentTab = 0;
     update();
  }

  selectActivityScreen() {
    _currentScreen = const TripHistoryMenu();
    _currentTab = 1;
    update();
  }

  selectNotificationScreen() {
    _currentScreen = const NotificationMenu();
    _currentTab = 2;
    update();
  }

  selectWalletScreen() {
    _currentScreen = const WalletScreenMenu();
    _currentTab = 3;
    update();
  }
}
