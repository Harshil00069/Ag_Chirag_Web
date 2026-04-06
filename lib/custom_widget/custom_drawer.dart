import 'package:ag_chirag_web/common_controller/custom_controller.dart';
import 'package:ag_chirag_web/config/app_colors.dart';
import 'package:ag_chirag_web/config/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  final bool isDesktop;
  const CustomDrawer({super.key, required this.isDesktop});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final CommonController commonCtrl = Get.find<CommonController>();
  double kTabletBreakpoint = 400.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.toNamed(commonCtrl.selectedRoute.value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return _buildSidebar(context, widget.isDesktop);
  }

  // --- Sidebar/Drawer Builder ---
  Widget _buildSidebar(BuildContext context, bool isDrawer) {
    return Container(
      width: isDrawer ? 250 : 280, // Fixed width for sidebar
      color: Colors.black, // Dark sidebar color
      child: Obx(()=> ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header (T-Store)
          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Text(
              'T-Store',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          // OVERVIEW & MEDIA
          _buildMenuSectionHeader('OVERVIEW & MEDIA'),
          _buildSidebarItem(
            1,
            context,
            'Dashboard',
            Icons.dashboard,
            isDrawer,
            AppRoutes.dashboardScreen,
            commonCtrl.selectedRoute.value,
          ),
          // PRODUCT MANAGEMENT
          _buildMenuSectionHeader('PRODUCT MANAGEMENT'),
          _buildSidebarItem(
            2,
            context,
            'Add new product',
            Icons.add_box,
            isDrawer,
            AppRoutes.addNewProductScreen,
            commonCtrl.selectedRoute.value,
          ),
          _buildSidebarItem(
            3,
            context,
            'Products',
            Icons.shopping_bag_outlined,
            isDrawer,
            AppRoutes.productListScreen,
            commonCtrl.selectedRoute.value,
          ),
          _buildSidebarItem(
            5,
            context,
            'Customers',
            Icons.people_outline,
            isDrawer,
            AppRoutes.userListScreen,
            commonCtrl.selectedRoute.value,
          ),
          _buildSidebarItem(
            6,
            context,
            'Orders',
            Icons.receipt_long,
            isDrawer,
            "Orders",
            commonCtrl.selectedRoute.value,
          ),
          _buildSidebarItem(
            7,
            context,
            'LogOut',
            Icons.logout,
            isDrawer,
            "LogOut",
            commonCtrl.selectedRoute.value,
          ),

          // PROMOTION MANAGEMENT (Not fully visible, just adding for structure)
          // _buildMenuSectionHeader('PROMOTION MANAGEMENT'),
        ],
      )),
    );
  }

  // Helper widget for menu section titles
  Widget _buildMenuSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildSidebarItem(
      int index,
      BuildContext context,
      String title,
      IconData icon,
      bool isDrawer,
      String itemRouteId,
      String currentSelectedId,
      ) {
    // print("itemRouteId=> ${itemRouteId}");
    final isSelected = itemRouteId == currentSelectedId;
    return InkWell(
      onTap: () async {
        commonCtrl.selectedRoute.value = itemRouteId;
        print("Selected Value=> ${commonCtrl.selectedRoute.value}");
        if(itemRouteId == AppRoutes.dashboardScreen){
          Get.offAllNamed(itemRouteId);
        }else{
          
          await Get.toNamed(itemRouteId);
          // logOut(context);
          // await  Get.offAllNamed(AppRoutes.loginScreen);
        }
        String currentPageName = Get.currentRoute;
        // print("Current Page Name=> $currentPageName");
        commonCtrl.selectedRoute.value = currentPageName;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 0),
        child: MouseRegion(onHover: commonCtrl.onEnter,
          onEnter: (_) => commonCtrl.onHover(index),
          onExit: (_) => commonCtrl.onExit(),
          child: Obx((){
            final isHovering =  commonCtrl.hoverIndex.value == index;
            return AnimatedContainer(
              decoration: BoxDecoration(
                color: isSelected || isHovering
                    ? AppColor.drawerSelectedColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(8),
              duration: Duration(milliseconds: 200),
              child: Row(
                children: [
                  Icon(icon, color: isHovering ||isSelected ? Colors.white : Colors.white70),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: isHovering || isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }


  Future logOut(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut().then((value) {
        Get.offAndToNamed(AppRoutes.loginScreen);
      });
    } catch (e) {
      print("error");
    }
  }

}
