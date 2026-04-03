import 'package:ag_chirag_web/config/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommonController extends GetxController {
  RxString selectedRoute = AppRoutes.dashboardScreen.obs;
  var hoverIndex = (-1).obs;
  var isHovering = false.obs;

  void onEnter(PointerEvent event) {
    isHovering.value = true;
  }
  void onHover(int index) => hoverIndex.value = index;
  // void onExit(PointerEvent event) {
  //   isHovering.value = false;
  // }

  void onExit() => hoverIndex.value = -1;
}