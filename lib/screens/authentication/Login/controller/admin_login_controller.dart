import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController {

RxBool isAdminLoading = false.obs;

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
RxBool isPasswordVisible = false.obs;


// Future<void> insertUpdateStudRegistrationData() async {
//   isAdminLoading.value = true;
//   try {
//     var response =
//     await ApiImplementor.adminLoginApiImplementer(
//       email: emailController.text.trim(),
//       pwd: passwordController.text.trim(),
//     );
//     if (response.status == 1) {
//       await UserInfo.setLoginUserDetailBucket(userData: response);
//       ConfigToast.showToast( message: response.message, type: ToastType.success);
//       clearAllController();
//     }else{
//       ConfigToast.showToast( message: response.message, type: ToastType.error);
//     }
//     isAdminLoading.value = false;
//   } catch (e) {
//     ConfigToast.showToast( message: e.toString(), type: ToastType.error);
//     isAdminLoading.value = false;
//   }
// }
//
//  void clearAllController() {
//   emailController.clear();
//   passwordController.clear();
//  }
//
// bool onCheckAllFieldsValidation() {
//   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//
//   if (emailController.text.trim().isEmpty) {
//     ConfigToast.showToast(message: "You Have Miss Email Its Required", type: ToastType.error);
//     return false;
//   } else if (!emailRegex.hasMatch(emailController.text.trim())) {
//     ConfigToast.showToast( message: "Enter a valid email address", type: ToastType.error);
//     return false;
//   } else if (passwordController.text.trim().isEmpty) {
//     ConfigToast.showToast(message: "You Have Miss Password Its Required", type: ToastType.error);
//     return false;
//   } else {
//     return true;
//   }
// }

}