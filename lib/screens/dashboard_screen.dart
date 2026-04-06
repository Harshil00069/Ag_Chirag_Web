import 'package:ag_chirag_web/config/app_colors.dart';
import 'package:ag_chirag_web/custom_widget/common_header.dart';
import 'package:ag_chirag_web/custom_widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double kTabletBreakpoint = 890.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // print("Width=> ${constraints.maxWidth}");
        final bool isDesktop = constraints.maxWidth > kTabletBreakpoint;
        // print("check condition=> ${constraints.maxWidth > kTabletBreakpoint} ${constraints.maxWidth}> ${kTabletBreakpoint}");
        return Scaffold(
          backgroundColor: Colors.white,
          // --- Core Layout Logic --
          body: Builder(builder: (context) {
            return  isDesktop
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDrawer(isDesktop: false,),
                Expanded(
                  child: _buildDashboardContent(
                    isDesktop: isDesktop,
                    context: context,
                  ),
                ),
              ],
            )
            // Main Content Area for Mobile/Tablet (uses the full width)
                : _buildDashboardContent(isDesktop: isDesktop, context: context);
          },),

          // Drawer for Mobile/Tablet
          drawer: isDesktop
              ? null
              : Drawer(child:  CustomDrawer(isDesktop: true,),),
        );
      },
    );
  }

  // --- Dashboard Content Builder ---
  Widget _buildDashboardContent({
    required bool isDesktop,
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(isDesktop: isDesktop, context: context),
          /*Row(
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
          ),*/
          Container(
            color: AppColor.secondary,
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dashboard Types',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // 2. Metric Cards Grid
                  // _buildMetricCardsGrid(isDesktop: isDesktop),
                  // const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // 3. Charts Section (Responsive Row/Column)
          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     // Switch to column layout if the width is less than 900px
          //     final isNarrowLayout = constraints.maxWidth < 900;
          //     return isNarrowLayout
          //         ? Column(
          //       children: [
          //         _buildWeeklySalesCard(),
          //         const SizedBox(height: 20),
          //         _buildOrdersStatusCard(),
          //       ],
          //     )
          //         : Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(flex: 3, child: _buildWeeklySalesCard()),
          //         const SizedBox(width: 20),
          //         Expanded(flex: 2, child: _buildOrdersStatusCard()),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }


}
