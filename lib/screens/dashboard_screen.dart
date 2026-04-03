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
                  _buildMetricCardsGrid(isDesktop: isDesktop),
                  const SizedBox(height: 30),
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

  // Widget to build the 4 metric cards
  Widget _buildMetricCardsGrid({required bool isDesktop,}) {
    // Data list mimicking the screenshot
    final List<Map<String, String>> metrics = [
      {
        'title': 'Sales total',
        'value': '\$204,192.05',
        'icon': "shopping_cart_outlined",
        'color': 'red',
      },
      {
        'title': 'Average Order Value',
        'value': '\$598.80',
        'icon': "money",
        'color': 'green',
      },
      {
        'title': 'Total Orders',
        'value': '\$341',
        'icon': "receipt_long",
        'color': 'purple',
      },
      {
        'title': 'Sold Products',
        'value': '\$520',
        'icon': "production_quantity_limits",
        'color': 'orange',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350, // Max width of each card before wrapping
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: isDesktop ?2.2 :1.8, // Taller aspect ratio to fit content
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final item = metrics[index];
        final Color color = Colors.blue; // Using a single color for simplicity
        return Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        getIcon(metrics[index]["icon"].toString()),
                        color: color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                Text(
                  item['value']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData getIcon(String name) {
    switch (name) {
      case "shopping_cart_outlined":
        return Icons.shopping_cart_outlined;
      case "money":
        return Icons.money;
      case "receipt_long":
        return Icons.receipt_long;
      case "production_quantity_limits":
        return Icons.production_quantity_limits;
      default:
        return Icons.help;
    }
  }

  /*  // Placeholder for the Weekly Sales Chart Card
  Widget _buildWeeklySalesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Sales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // *** Placeholder for the bar chart widget ***
            AspectRatio(
              aspectRatio: 1.8,
              child: Center(
                child: Text('Bar Chart Placeholder'),
              ),
            ),
            // *******************************************
          ],
        ),
      ),
    );
  }

  // Placeholder for the Orders Status Donut/Pie Chart Card
  Widget _buildOrdersStatusCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // *** Placeholder for the donut chart widget ***
            AspectRatio(
              aspectRatio: 1.0,
              child: Center(
                child: Text('Donut Chart Placeholder'),
              ),
            ),
            // ********************************************
          ],
        ),
      ),
    );
  }*/
}
