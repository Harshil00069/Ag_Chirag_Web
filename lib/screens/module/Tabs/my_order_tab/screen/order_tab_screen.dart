import 'package:ag_chirag_web/screens/module/Tabs/my_order_tab/controller/order_tab_controller.dart';
import 'package:ag_chirag_web/screens/module/Tabs/my_order_tab/model/order_book_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTabScreen extends StatefulWidget {
  const OrderTabScreen({super.key});

  @override
  State<OrderTabScreen> createState() => _OrderTabScreenState();
}

class _OrderTabScreenState extends State<OrderTabScreen> {
  OrderTabController orderTabController = Get.put(OrderTabController());
  final _filters = ['All', 'BUY', 'SELL', 'Pending', 'Completed', 'Rejected'];
  String _filter = 'All'; // All | BUY | SELL | Pending | Completed | Rejected
  List<OrderBookData> get _filtered {
    switch (_filter) {
      case 'BUY':
        return orderTabController.orderList.where((o) => o.isBuy).toList();
      case 'SELL':
        return orderTabController.orderList.where((o) => !o.isBuy).toList();
      case 'Pending':
        return orderTabController.orderList.where((o) => o.isPending).toList();
      case 'Completed':
        return orderTabController.orderList.where((o) => o.isComplete).toList();
      case 'Rejected':
        return orderTabController.orderList.where((o) => o.isRejected).toList();
      default:
        return orderTabController.orderList;
    }
  }

  @override
  void initState() {
    orderTabController.getOrdersListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [_buildTableCard()]));
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
          Obx(() => _buildBody()),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Text(
            'Orders',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(width: 14),
          // Filter pills
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters
                    .map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: GestureDetector(
                          onTap: () => setState(() => _filter = f),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _filter == f
                                  ? const Color(0xFF2563EB)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _filter == f
                                    ? const Color(0xFF2563EB)
                                    :  Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              f,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: _filter == f
                                    ? Colors.white
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Refresh button
          InkWell(
            onTap: () {
              orderTabController.getOrdersListApi();
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    size: 14,
                    color: Color(0xFF6B7280),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Body ───────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    if (orderTabController.isOrderLoading.value) return loadingState();
    if (_filtered.isEmpty) return emptyState(filter: _filter);
    return _buildTable();
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
            0: FixedColumnWidth(110), // Actions
            1: FixedColumnWidth(130), // Client Name
            2: FixedColumnWidth(160), // Trading Symbol
            3: FixedColumnWidth(100), // Product Type
            4: FixedColumnWidth(100), // Price
            5: FixedColumnWidth(110), // Avg Price
            6: FixedColumnWidth(65), // Qty
            7: FixedColumnWidth(50), // TXN
            8: FixedColumnWidth(75), // Exchange
            9: FixedColumnWidth(95), // Status
          },
          children: [
            // ── Header ──────────────────────────────────────────────────
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
              children:
                  [
                        '',
                        'Client Name',
                        'Trading Symbol',
                        'Product Type',
                        'Price',
                        'Avg Price',
                        'Qty',
                        'TXN',
                        'Exchange',
                        'Status',
                      ]
                      .map(
                        (h) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
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

            // ── Data rows ───────────────────────────────────────────────
            ..._filtered.map(
              (o) => TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
                ),
                children: [
                  // Actions: Bulk Edit + Edit + Delete
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 9,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        iconActionButton(
                          icon: Icons.edit_note_rounded,
                          tooltip: 'Bulk Edit',
                          color: const Color(0xFF991B1B),
                          bg: const Color(0xFFFEE2E2),
                          onTap: () {},
                        ),
                        const SizedBox(width: 4),
                        iconActionButton(
                          icon: Icons.edit_outlined,
                          tooltip: 'Edit',
                          color: const Color(0xFF1D4ED8),
                          bg: const Color(0xFFEFF6FF),
                          onTap: () {},
                        ),
                        const SizedBox(width: 4),
                        iconActionButton(
                          icon: Icons.delete_outline_rounded,
                          tooltip: 'Delete',
                          color: const Color(0xFFDC2626),
                          bg: const Color(0xFFFEF2F2),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Client Name
                  cell(
                    child: Text(
                      o.clientName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),

                  // Trading Symbol
                  cell(
                    child: Text(
                      o.tradingsymbol,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),

                  // Product Type
                  cell(child: productBadge(product: o.producttype)),

                  // Price
                  cell(
                    child: Text(
                      '₹${o.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: o.isBuy
                            ? const Color(0xFF16A34A)
                            : const Color(0xFFDC2626),
                      ),
                    ),
                  ),

                  // Avg Price
                  cell(
                    child: Text(
                      '₹${o.averageprice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),

                  // Qty
                  cell(
                    child: Text(
                      o.quantity,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),

                  // TXN
                  cell(
                    child: Text(
                      o.transactiontype,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: o.isBuy
                            ? const Color(0xFF16A34A)
                            : const Color(0xFFDC2626),
                      ),
                    ),
                  ),

                  // Exchange
                  cell(child: exchangeBadge(exchange: o.exchange)),

                  // Status
                  cell(child: statusBadge(status: o.status)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color bg,
    required Color color,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 15, color: color),
        ),
      ),
    );
  }

  Widget cell({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: child,
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

  Widget emptyState({required String filter}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF9CA3AF),
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              filter == 'All' ? 'No orders yet' : 'No $filter orders',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Orders will appear here once placed',
              style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
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

  Widget exchangeBadge({required String exchange}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          exchange,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF166534),
          ),
        ),
      ),
    );
  }

  Widget statusBadge({required String status}) {
    Color bg;
    Color fg;
    String label;
    switch (status.toLowerCase()) {
      case 'complete':
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF166534);
        label = 'Complete';
        break;
      case 'pending':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFF92400E);
        label = 'Pending';
        break;
      case 'rejected':
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFF991B1B);
        label = 'Rejected';
        break;
      default:
        bg = const Color(0xFFEFF6FF);
        fg = const Color(0xFF1D4ED8);
        label = status;
    }
    return SizedBox(
      width: 78,
      height: 24,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ),
    );
  }
}
