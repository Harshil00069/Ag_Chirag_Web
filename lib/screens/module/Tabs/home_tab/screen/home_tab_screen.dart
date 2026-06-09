import 'package:ag_chirag_web/screens/module/Tabs/home_tab/controller/home_tab_controller.dart';
import 'package:ag_chirag_web/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'add_user_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  HomeTabController homeScreenController = Get.put(HomeTabController());

  Color vc(String v) => v.startsWith('+')
      ? const Color(0xFF16A34A)
      : v == '—'
      ? const Color(0xFF9CA3AF)
      : const Color(0xFFDC2626);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'User Overview',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Row(
                      children: [
                        actionBtn(
                          label: 'Fetch User',
                          onTap: () {
                            homeScreenController.fetchUsers();
                          },
                        ),
                        const SizedBox(width: 8),
                        actionBtn(label: 'Login Users', onTap: () {
                          homeScreenController.initializeData();
                        }),
                        const SizedBox(width: 8),
                        actionBtn(
                          label: '+ Add User',
                          onTap: () {
                            Get.to(AddUserScreen());
                          },
                          primary: true,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(()=> buildBody()),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
    padding: padding ?? const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Color(0x06000000),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );

  Widget actionBtn({
    required String label,
    required VoidCallback onTap,
    bool primary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: primary ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: primary ? const Color(0xFF2563EB) : const Color(0xFFD1D5DB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: primary ? Colors.white : const Color(0xFF374151),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    if (homeScreenController.loading.value) return _LoadingState();
    _ErrorState(
      error: homeScreenController.error,
      onRetry: homeScreenController.fetchUsers,
    );
    if (homeScreenController.usersList.isEmpty) {
      return _EmptyState(hasSearch: homeScreenController.usersList.isNotEmpty);
    }
    return userTable();
  }

  Widget userTable() {
    return Stack(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.5), // User ID
            1: FlexColumnWidth(2.5), // User Name (Gives breathing room for long names)
            2: FlexColumnWidth(1.5), // Position PNL
            3: FlexColumnWidth(1.5), // Balance
            4: FlexColumnWidth(1.2), // Status (Fits the status badge perfectly)
            5: FlexColumnWidth(1.5), // Controller (Gives extra horizontal space for edit/delete)
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
              children: [
                'User ID',
                'User Name',
                'Position PNL',
                'Balance',
                'Status',
                "Controller",
              ].map(
                    (h) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12, // Increased slightly to match body rows
                  ),
                  child: Text(
                    h,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ).toList(),
            ),
            ...homeScreenController.usersList.asMap().entries.map(
                  (entry) {
                int index = entry.key;
                var u = entry.value;

                return TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
                  ),
                  children: [
                    // 0. User ID
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      child: Text(
                        u.clientcode.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    // 1. User Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: const Color(0xFFEDE9FE),
                            child: Text(
                              (u.username.toString())[0],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5B21B6),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            u.username.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 2. Position PNL
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      child: Text(
                        u.positionPNL.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: vc(u.positionPNL.toString()),
                        ),
                      ),
                    ),
                    // 3. Balance
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      child: Text(
                        u.currentBalance.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // 4. Status Column (Wrapped in TableCell for Vertical Alignment)
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerLeft, // Prevents container from stretching
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (u.jwtToken.isNotEmpty)
                                  ? const Color(0xFFDCFCE7)
                                  : const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: (u.jwtToken.isNotEmpty)
                                      ? const Color(0xFF16A34A)
                                      : const Color(0xFFDC2626),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  (u.jwtToken.isNotEmpty) ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: (u.jwtToken.isNotEmpty)
                                        ? const Color(0xFF166534)
                                        : const Color(0xFF991B1B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 5. Controller Column (Wrapped in TableCell + Added spacing and constraints)
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(), // Removes material density padding
                              padding: const EdgeInsets.all(4),
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () {
                                Get.to(
                                  AddUserScreen(
                                    clientData: u,
                                    documentId: u.userId,
                                    index: index,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12), // Adds beautiful breathing room between actions
                            IconButton(
                              constraints: const BoxConstraints(), // Removes material density padding
                              padding: const EdgeInsets.all(4),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ) // Fixed missing .toList() error from your map closure
          ],
        ),
        Obx(
              () => homeScreenController.isLoginApiLoading.value
              ? Container(
            color: Colors.grey.withValues(alpha: 0.3),
            child: Center(
              child: AppDialogs.progressWidget(),
            ),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2563EB)),
            SizedBox(height: 12),
            Text(
              'Loading users...',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Color(0xFFDC2626),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Failed to load users',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 15),
              label: const Text('Try again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasSearch;

  const _EmptyState({required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                hasSearch
                    ? Icons.search_off_rounded
                    : Icons.people_outline_rounded,
                color: const Color(0xFF9CA3AF),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              hasSearch ? 'No users match your search' : 'No users yet',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hasSearch
                  ? 'Try a different name or ID'
                  : 'Click "Add User" to get started',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}
