import 'package:ag_chirag_web/common_controller/custom_controller.dart';
import 'package:ag_chirag_web/config/app_pages.dart';
import 'package:ag_chirag_web/config/globals.dart';
import 'package:ag_chirag_web/screens/splesh_screen.dart';
import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  Get.put(
      CommonController(),
      permanent: true
  );

  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      navigatorKey: Globals.navigatorKey,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Admin Panel',
      getPages: AppPages.pages,
      // initialRoute: AppRoutes.loginScreen,
      home: SplashScreen(),
      supportedLocales: const [
        // List all locales your app (and Quill) supports
        Locale('en', 'US'),
        Locale('es', 'ES'),
        // Add more locales here...
      ],
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   FlutterQuillLocalizations.delegate,
      // ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
