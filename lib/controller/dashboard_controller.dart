import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../utils/base_functions.dart';

class DashboardController extends GetxController {
  RxInt pageIndex = 0.obs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RxBool canPop = false.obs;
  DateTime currentBackPressTime = DateTime.now();

  onWillPop(bool didPop, dynamic val) {
    triggerHapticFeedback();
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      scaffoldKey.currentState?.closeDrawer();
      canPop.value = false;
    } else {
      DateTime now = DateTime.now();
      if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Press back again to exit app");
        canPop.value = false;
      } else {
        canPop.value = true;
      }
    }
  }
}
