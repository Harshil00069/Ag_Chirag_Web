import 'package:ag_chirag_web/constant/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class ConfigToast {
  ConfigToast._(); // Private constructor

  static void showToast({
    required String message,
    required ToastType type,
    String? title,
  }) {
    final context = Get.overlayContext;
    print("context=> $context");
    // 1. Safety check to prevent crashing if context is null
    if (context == null) return;
    // Define common settings
    const alignment = Alignment.topRight;
    const animationType = AnimationType.slideInFromRight;
    final description = Text(message,style: TextStyle(color: Colors.white),);

    if (type == ToastType.success) {
      MotionToast.success(
        opacity: 0.8,
        toastDuration: const Duration(milliseconds: 2000),
        title: Text(title ?? "Success",style: TextStyle(color: Colors.white),),
        description: description,
        toastAlignment: alignment,
        // animationType: animationType,
      ).show(context);
    } else if (type == ToastType.error) {
      MotionToast.error(
        opacity: 0.8,
        toastDuration: const Duration(milliseconds: 2000),
        title: Text(title ?? "Error",style: TextStyle(color: Colors.white),),
        description: description,
        toastAlignment: alignment,
        // animationType: animationType,
      ).show(context);
    } else if (type == ToastType.warning) {
      MotionToast.warning(
        opacity: 0.8,
        toastDuration: const Duration(milliseconds: 2000),
        title: Text(title ?? "Warning",style: TextStyle(color: Colors.white),),
        description: description,
        toastAlignment: alignment,
        animationType: animationType,
      ).show(context);
    } else {
      MotionToast.info(
        opacity: 0.8,
        toastDuration: const Duration(milliseconds: 2000),
        title: Text(title ?? "Info",style: TextStyle(color: Colors.white),),
        description: description,
        toastAlignment: alignment,
        animationType: animationType,
      ).show(context);
    }
  }

}

