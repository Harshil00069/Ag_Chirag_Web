import 'package:ag_chirag_web/screens/module/Tabs/position_data_tab/controller/position_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PositionTabScreen extends StatefulWidget {
  const PositionTabScreen({super.key});

  @override
  State<PositionTabScreen> createState() => _PositionTabScreenState();
}

class _PositionTabScreenState extends State<PositionTabScreen> {
  PositionTabController positionTabController = Get.put(
    PositionTabController(),
  );

  @override
  void initState() {
    super.initState();
    positionTabController.getPositionList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [_buildTableCard()]),
    );
  }

  Widget _buildTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Color(0x06000000), blurRadius: 8)],
      ),
      child: Column(
        children: [
          _buildToolbar(),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          Obx(()=> _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (positionTabController.isDataLoading.value) return loadingState();
    if (positionTabController.positionList.isEmpty) return emptyState();
    return _buildTable();
  }

  // ── Toolbar ────────────────────────────────────────────────────────────────
  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: Row(
        children: [
          const Text(
            'Open Positions',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const Spacer(),
          toolbarBtn(
            icon: Icons.refresh_rounded,
            label: 'Refresh',
            onTap: () {
              positionTabController.getPositionList();
            },
          ),
        ],
      ),
    );
  }

  // ── Table ──────────────────────────────────────────────────────────────────
  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 80,
        ),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(110),
            1: FixedColumnWidth(130),
            2: FixedColumnWidth(70),
            3: FixedColumnWidth(130),
            4: FixedColumnWidth(80),
            5: FixedColumnWidth(160),
            6: FixedColumnWidth(70),
            7: FixedColumnWidth(110),
            8: FixedColumnWidth(110),
            9: FixedColumnWidth(90),
          },
          children: [
            // Header
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
              children:
                  [
                        '',
                        'Client Name',
                        'Exchange',
                        'Product Type',
                        'Option',
                        'Symbol',
                        'Net Qty',
                        'Avg Net Price',
                        'P&L',
                        'LTP',
                      ]
                      .map(
                        (h) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          child: Text(
                            h,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            // Data rows
            ...positionTabController.positionList.map(
              (p) => TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
                ),
                children: [
                  // Bulk Edit button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: const Color(0xFFFECACA),
                            width: 0.5,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 12,
                              color: Color(0xFF991B1B),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Bulk Edit',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF991B1B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Client Name
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      p.clientName.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Exchange
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: exchangeBadge(exchange: p.exchange.toString()),
                  ),
                  // Product Type
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: productBadge(product: p.producttype.toString()),
                  ),
                  // Option Type
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: optionBadge(type: p.optiontype.toString()),
                  ),
                  // Symbol
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      p.symbolname.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  // Net Qty
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      '${p.netqty}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Avg Net Price
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      '₹${p.avgnetprice}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // P&L
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          p.isPnlPositive
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                          size: 16,
                          color: p.isPnlPositive
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFDC2626),
                        ),
                        Text(
                          '₹${p.pnl}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: p.isPnlPositive
                                ? const Color(0xFF16A34A)
                                : const Color(0xFFDC2626),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // LTP
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      '₹${p.ltp}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingState() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2563EB)),
          SizedBox(height: 12),
          Text(
            'Loading positions...',
            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget emptyState() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.candlestick_chart_outlined,
            color: Color(0xFF9CA3AF),
            size: 32,
          ),
          SizedBox(height: 10),
          Text(
            'No open positions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Positions will appear here once opened',
            style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget exchangeBadge({required String exchange}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        exchange,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF166534),
        ),
      ),
    );
  }

  Widget productBadge({required String product}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          product.length > 12 ? '${product.substring(0, 12)}..' : product,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4C1D95),
          ),
        ),
      ),
    );
  }

  Widget optionBadge({required String type}) {
    final isCe = type.toUpperCase() == 'CE';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isCe ? const Color(0xFFEFF6FF) : const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          type,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isCe ? const Color(0xFF1D4ED8) : const Color(0xFF92400E),
          ),
        ),
      ),
    );
  }

  Widget toolbarBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool primary = false,
    bool danger = false,
  }) {
    Color bg = primary
        ? const Color(0xFF2563EB)
        : danger
        ? const Color(0xFFFEE2E2)
        : Colors.transparent;
    Color fg = primary
        ? Colors.white
        : danger
        ? const Color(0xFF991B1B)
        : const Color(0xFF374151);
    Color bdr = primary
        ? const Color(0xFF2563EB)
        : danger
        ? const Color(0xFFFECACA)
        : const Color(0xFFD1D5DB);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
