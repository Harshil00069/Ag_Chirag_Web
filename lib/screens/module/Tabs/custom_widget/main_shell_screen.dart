import 'package:ag_chirag_web/screens/module/Tabs/home_tab/screen/home_tab_screen.dart';
import 'package:ag_chirag_web/screens/module/Tabs/position_data_tab/screen/position_tab_screen.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/screen/watch_list_tab_screen.dart';
import 'package:flutter/material.dart';

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

const _navItems = [
  _NavItem(icon: Icons.dashboard_rounded,          label: 'Home'),
  // _NavItem(icon: Icons.search_rounded,             label: 'Search Share'),
  _NavItem(icon: Icons.visibility_rounded,         label: 'Watch List'),
  _NavItem(icon: Icons.receipt_long_rounded,       label: 'Orders'),
  _NavItem(icon: Icons.shopping_basket_rounded,    label: 'Basket Order'),
  _NavItem(icon: Icons.candlestick_chart_rounded,  label: 'Position'),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _navItems.length, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          // ── Single compact header (logo + tabs + actions all in one row) ──
          Container(
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF0F1A2E),
              boxShadow: [
                BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                // Logo
                const SizedBox(width: 16),
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 10),
                const Text('TradeDesk',
                    style: TextStyle(
                      color: Colors.white, fontSize: 14,
                      fontWeight: FontWeight.w700, letterSpacing: 0.3,
                    )),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF166534),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(children: [
                    Icon(Icons.circle, color: Color(0xFF4ADE80), size: 5),
                    SizedBox(width: 3),
                    Text('Live', style: TextStyle(color: Color(0xFF4ADE80), fontSize: 10, fontWeight: FontWeight.w600)),
                  ]),
                ),

                // ── Tabs inline ──
                const SizedBox(width: 20),
                Expanded(
                  child: TabBar(
                    controller: _tab,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF6B7FA8),
                    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.white, width: 6),
                      insets: EdgeInsets.symmetric(horizontal: 2),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    padding: EdgeInsets.zero,
                    tabs: _navItems.map((t) => Tab(
                      height: 52,
                      child: SizedBox(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(t.icon, size: 14),
                          const SizedBox(width: 5),
                          Text(t.label,style: TextStyle(fontSize: 16),),
                        ]),
                      ),
                    )).toList(),
                  ),
                ),

                // ── Right actions ──
                const SizedBox(width: 12),
                // Container(
                //   width: 160, height: 28,
                //   decoration: BoxDecoration(
                //     color: const Color(0xFF1E3A5F),
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   child: const Row(children: [
                //     SizedBox(width: 8),
                //     Icon(Icons.search, color: Color(0xFF6B7FA8), size: 13),
                //     SizedBox(width: 5),
                //     Text('Search...', style: TextStyle(color: Color(0xFF6B7FA8), fontSize: 12)),
                //   ]),
                // ),
                // const SizedBox(width: 10),
                // Stack(children: [
                //   const Icon(Icons.notifications_none_rounded, color: Color(0xFF6B7FA8), size: 20),
                //   Positioned(right: 0, top: 0,
                //       child: Container(width: 7, height: 7,
                //           decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle))),
                // ]),
                const SizedBox(width: 12),
                CircleAvatar(radius: 14, backgroundColor: const Color(0xFF2563EB),
                    child: const Text('H', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                const SizedBox(width: 16),
              ],
            ),
          ),

          // ── Full-height content ──
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                HomeTabScreen(),
                WatchListTabScreen(),
                HomeTabScreen(),
                HomeTabScreen(),
                PositionTabScreen(),
                // SearchShareTab(),
                // WatchListTab(),
                // OrdersTab(),
                // BasketOrderTab(),
                // PositionTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}