import 'package:ag_chirag_web/screens/authentication/Login/screen/login_screen.dart';
import 'package:ag_chirag_web/screens/dashboard_screen.dart';
import 'package:ag_chirag_web/screens/module/user/screen/user_list_screen.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  static const loginScreen = '/login';
  static const dashboardScreen = '/dashboard-screen';
  static const addNewProductScreen = '/add-new-product';
  static const updateProductScreen = '/update-product';
  static const productListScreen = '/Product-List';
  static const userListScreen = '/User-List-Screen';
}

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
    GetPage(name: AppRoutes.dashboardScreen, page: () => DashboardScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
    // GetPage(name: AppRoutes.addNewProductScreen, page: () => AddNewProductScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
    // GetPage(name: AppRoutes.productListScreen, page: () => ProductListScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
    // GetPage(name: AppRoutes.updateProductScreen, page: () => UpdateProductScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
    GetPage(name: AppRoutes.userListScreen, page: () => UserListScreen(),transition: Transition.fadeIn,  transitionDuration: Duration(milliseconds: 400),),
  ];
}