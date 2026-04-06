import 'package:ag_chirag_web/config/app_pages.dart';
import 'package:ag_chirag_web/utils/image_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goToRespectiveRoutes();
    });

  }

  Future<void> goToRespectiveRoutes() async {
    var redirectRoute = '';
    if (await checkLogin()) {
      redirectRoute = AppRoutes.dashboardScreen;
    } else {
      redirectRoute = AppRoutes.loginScreen;
    }
    Get.offAllNamed(redirectRoute);
  }

  Future<bool> checkLogin()async{
    bool isUserLoginCheck = false;
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      isUserLoginCheck = true;
    }
    return isUserLoginCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: logoWidget(),
      ),
    );
  }

  Widget logoWidget(){
    return LottieBuilder.asset(
      ImagesPath.updateAppGif,
      fit: BoxFit.fill,
      width: Get.width * 0.4,
      height: Get.height * 0.06,
    );
  }
}

