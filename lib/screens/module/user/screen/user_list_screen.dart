import 'package:ag_chirag_web/common_controller/custom_controller.dart';
import 'package:ag_chirag_web/config/app_colors.dart';
import 'package:ag_chirag_web/custom_widget/custom_drawer.dart';
import 'package:ag_chirag_web/screens/module/user/controller/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  double kTabletBreakpoint = 950.0;
  final CommonController commonCtrl = Get.find<CommonController>();
  final UserDetailController controller = Get.put(UserDetailController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double effectiveWidth = constraints.maxWidth < kTabletBreakpoint
            ? kTabletBreakpoint
            : constraints.maxWidth;
        final bool isDesktop = constraints.maxWidth > kTabletBreakpoint;
        // print("check condition=> ${constraints.maxWidth > kTabletBreakpoint} ${constraints.maxWidth}> ${kTabletBreakpoint}");
        return Scaffold(
          backgroundColor: Colors.white,
          // --- Core Layout Logic --
          body: Builder(
            builder: (context) {
              return isDesktop
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDrawer(isDesktop: false),
                  Expanded(
                    child: _buildDashboardContent(
                      isDesktop: isDesktop,
                      context: context,
                      effectiveWidth: effectiveWidth,
                      effectiveHeight: constraints.maxHeight,
                    ),
                  ),
                ],
              )
              // Main Content Area for Mobile/Tablet (uses the full width)
                  : _buildDashboardContent(
                isDesktop: isDesktop,
                context: context,
                effectiveWidth: effectiveWidth,
                effectiveHeight: constraints.maxHeight,
              );
            },
          ),

          // Drawer for Mobile/Tablet
          drawer: isDesktop
              ? null
              : Drawer(child: CustomDrawer(isDesktop: true)),
        );
      },
    );
  }

  // --- Dashboard Content Builder ---
  Widget _buildDashboardContent({
    required bool isDesktop,
    required BuildContext context,
    required double effectiveWidth,
    required double effectiveHeight,
  }) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: !isDesktop
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (!isDesktop)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey Support',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'support@codingwitht.com',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: AppColor.secondary,
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 2. Metric Cards Grid
                    _buildProductList(width: effectiveWidth,isWeb: isDesktop),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildProductList({required double width , required bool isWeb}) {
    return Card(elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: width,
            height: controller.userList.length > 10 ? Get.height*0.68 :null,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Customer",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(40):FixedColumnWidth(160)),
                  DataColumn(label: Text("Email",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(60):FixedColumnWidth(200)),
                  DataColumn(label: Text("Phone Number",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(60):FixedColumnWidth(140)),
                  DataColumn(label: Text("Orders",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(60):FixedColumnWidth(100)),
                  DataColumn(label: Text("Register Date",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(60):FixedColumnWidth(130)),
                  DataColumn(label: Text("Action",style: TextStyle(fontWeight: FontWeight.w600),),columnWidth: isWeb ? FixedColumnWidth(60):FixedColumnWidth(130)),
                ],
                rows: controller.userList.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item.name,style: TextStyle(color: AppColor.drawerSelectedColor,fontWeight: FontWeight.w600),),),
                      DataCell(Text(item.email)),
                      DataCell(Text(item.phone)),
                      DataCell(Container(padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            color: AppColor.countColor,
                          ),
                          child: Text(item.orderCount.toString()))),
                      DataCell(Text(item.registerDate)),
                      DataCell(Row(
                        children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blueAccent), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
                        ],
                      )),
                    ],
                  );
                }).toList(),
                headingRowHeight: 50,
                dataRowMinHeight: 40,
                dataRowMaxHeight: 70,
                dividerThickness: 0,
                headingRowColor: WidgetStateProperty.all(AppColor.secondary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTag({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
class UserData {
  final String name;
  final String email;
  final String phone;
  final String registerDate;
  final int orderCount;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.registerDate,
    required this.orderCount,
  });
}